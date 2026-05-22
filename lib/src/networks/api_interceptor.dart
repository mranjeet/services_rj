import 'package:dio/dio.dart';

abstract class ApiInterceptor {
  Future<void> onRequest(RequestOptions options) async {}

  Future<void> onResponse(Response response) async {}

  Future<void> onError(DioException error) async {}
}
