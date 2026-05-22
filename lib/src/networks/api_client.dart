import 'package:dio/dio.dart';
import 'api_exception.dart';
import 'api_methods.dart';
import 'api_request.dart';
import 'api_response.dart';
import 'dio_service.dart';
import 'handlers/exception_handler.dart';
import 'handlers/response_handler.dart';
import 'models/download_progress.dart';
import 'models/upload_progress.dart';
import 'request_type.dart';

class ApiClient {
  ApiClient._();

  static final ApiClient instance = ApiClient._();

  Dio get _dio => DioService.instance.dio;

  // ---------------------------------------------------------------------------
  // COMMON REQUEST METHOD
  // ---------------------------------------------------------------------------

  Future<ApiResponse<dynamic>> request(ApiRequest request) async {
    try {
      late ApiResponse<dynamic> response;

      switch (request.requestType) {
        case RequestType.normal:
          response = await _normalRequest(request);
          break;

        case RequestType.upload:
          response = await _uploadRequest(request);
          break;

        case RequestType.download:
          return await _downloadRequest(request);
      }

      return ResponseHandler.handle(response);
    } on DioException catch (e, stackTrace) {
      throw ExceptionHandler.handle(e, stackTrace: stackTrace);
    } catch (e, stackTrace) {
      throw ExceptionHandler.handle(e, stackTrace: stackTrace);
    }
  }

  // ---------------------------------------------------------------------------
  // NORMAL REQUEST
  // ---------------------------------------------------------------------------

  Future<ApiResponse<dynamic>> _normalRequest(
    ApiRequest request,
  ) async {
    late Response response;

    switch (request.method) {
      case ApiMethod.get:
        response = await _dio.get(
          request.endpoint,
          queryParameters: request.queryParameters,
          options: Options(headers: request.headers),
          cancelToken: request.cancelRequest?.cancelToken,
        );
        break;

      case ApiMethod.post:
        response = await _dio.post(
          request.endpoint,
          data: request.body,
          queryParameters: request.queryParameters,
          options: Options(headers: request.headers),
          cancelToken: request.cancelRequest?.cancelToken,
        );
        break;

      case ApiMethod.put:
        response = await _dio.put(
          request.endpoint,
          data: request.body,
          queryParameters: request.queryParameters,
          options: Options(headers: request.headers),
          cancelToken: request.cancelRequest?.cancelToken,
        );
        break;

      case ApiMethod.patch:
        response = await _dio.patch(
          request.endpoint,
          data: request.body,
          queryParameters: request.queryParameters,
          options: Options(headers: request.headers),
          cancelToken: request.cancelRequest?.cancelToken,
        );
        break;

      case ApiMethod.delete:
        response = await _dio.delete(
          request.endpoint,
          data: request.body,
          queryParameters: request.queryParameters,
          options: Options(headers: request.headers),
          cancelToken: request.cancelRequest?.cancelToken,
        );
        break;
    }

    return ApiResponse(
      success: true,
      data: response.data,
      statusCode: response.statusCode,
    );
  }

  // ---------------------------------------------------------------------------
  // UPLOAD REQUEST
  // ---------------------------------------------------------------------------

  Future<ApiResponse<dynamic>> _uploadRequest(
    ApiRequest request,
  ) async {
    final formDataMap = <String, dynamic>{...?request.body};

    // Single File
    if (request.filePath != null) {
      formDataMap[request.fileField] = await MultipartFile.fromFile(
        request.filePath!,
        filename: request.filePath!.split('/').last,
      );
    }

    // Multiple Files
    if (request.files != null) {
      formDataMap[request.fileField] = await Future.wait(
        request.files!.map(
          (file) async => MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        ),
      );
    }

    final formData = FormData.fromMap(formDataMap);

    final response = await _dio.post(
      request.endpoint,
      data: formData,
      options: Options(headers: request.headers),
      cancelToken: request.cancelRequest?.cancelToken,
      onSendProgress: (sent, total) {
        request.onUploadProgress?.call(
          UploadProgress(sent: sent, total: total),
        );
      },
    );

    return ApiResponse(
      success: true,
      data: response.data,
      statusCode: response.statusCode,
    );
  }

  // ---------------------------------------------------------------------------
  // DOWNLOAD REQUEST
  // ---------------------------------------------------------------------------

  Future<ApiResponse<dynamic>> _downloadRequest(
    ApiRequest request,
  ) async {
    if (request.downloadSavePath == null) {
      throw ApiException(message: 'downloadSavePath is required');
    }

    await _dio.download(
      request.endpoint,
      request.downloadSavePath!,
      cancelToken: request.cancelRequest?.cancelToken,
      onReceiveProgress: (received, total) {
        request.onDownloadProgress?.call(
          DownloadProgress(received: received, total: total),
        );
      },
    );

    return ApiResponse(success: true, data: request.downloadSavePath);
  }
}
