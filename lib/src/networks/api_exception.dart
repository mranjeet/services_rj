class ApiException implements Exception {
  ApiException({required this.message, this.statusCode, this.data});

  final String message;

  final int? statusCode;

  final dynamic data;

  bool get isUnauthorized => statusCode == 401;

  bool get isValidationError => statusCode == 422;

  bool get isServerError => statusCode == 500;

  bool get isNotFound => statusCode == 404;

  @override
  String toString() {
    return "STATUS CODE-: $statusCode:: $message";
  }
}
