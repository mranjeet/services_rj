import 'dart:io';

import 'api_methods.dart';
import 'cancel_request.dart';
import 'models/download_progress.dart';
import 'models/upload_progress.dart';
import 'request_type.dart';

class ApiRequest {
  const ApiRequest({
    required this.endpoint,
    required this.method,

    this.requestType = RequestType.normal,

    this.body,
    this.queryParameters,
    this.headers,

    this.filePath,
    this.files,
    this.fileField = 'file',

    this.downloadSavePath,

    this.onUploadProgress,
    this.onDownloadProgress,

    this.cancelRequest,
  });

  final String endpoint;

  final ApiMethod method;

  final RequestType requestType;

  final dynamic body;

  final Map<String, dynamic>? queryParameters;

  final Map<String, dynamic>? headers;

  // ---------------------------------------------------------------------------
  // Upload
  // ---------------------------------------------------------------------------

  final String? filePath;

  final List<File>? files;

  final String fileField;

  // ---------------------------------------------------------------------------
  // Download
  // ---------------------------------------------------------------------------

  final String? downloadSavePath;

  // ---------------------------------------------------------------------------
  // Progress
  // ---------------------------------------------------------------------------

  final void Function(UploadProgress progress)? onUploadProgress;

  final void Function(DownloadProgress progress)? onDownloadProgress;

  // ---------------------------------------------------------------------------
  // Cancellation
  // ---------------------------------------------------------------------------

  final CancelRequest? cancelRequest;
}
