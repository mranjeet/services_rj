import 'package:dio/dio.dart';

class NetworkLogger extends Interceptor {
  NetworkLogger({this.printLogs = false});

  /// Controls whether the logs are printed to the console.
  /// Set to `true` (e.g. via [ApiConfig.printLogs]) to enable console output.
  final bool printLogs;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (printLogs) {
      print('[REQUEST] ${options.method} => ${options.uri}');
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (printLogs) {
      print(
        '[RESPONSE] ${response.statusCode} => ${response.requestOptions.uri}',
      );
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (printLogs) {
      print('[ERROR] ${err.message}');
    }

    handler.next(err);
  }
}
