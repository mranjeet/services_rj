import '../api_exception.dart';
import '../api_response.dart';

class ResponseHandler {
  static ApiResponse<dynamic> handle(ApiResponse<dynamic> response) {
    final statusCode = response.statusCode ?? 0;

    switch (statusCode) {
      case 200:
      case 201:
        return ApiResponse(
          success: true,
          data: response.data,
          statusCode: statusCode,
        );

      case 400:
      case 422:
      case 404:
      case 500:
        throw ApiException(
          message:
              response.data?['message'] ?? 'Something went wrong',
          statusCode: statusCode,
        );

      case 401:
        throw ApiException(
          message: 'Unauthorized',
          statusCode: statusCode,
        );

      default:
        throw ApiException(
          message: response.data?['message'] ?? 'Unknown error',
          statusCode: statusCode,
        );
    }
  }
}
