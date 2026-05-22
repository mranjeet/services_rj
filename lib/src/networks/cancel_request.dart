import 'package:dio/dio.dart';

class CancelRequest {
  CancelRequest();

  final CancelToken cancelToken = CancelToken();

  void cancel([String? reason]) {
    cancelToken.cancel(reason);
  }
}
