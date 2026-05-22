class UploadProgress {
  const UploadProgress({required this.sent, required this.total});

  final int sent;

  final int total;

  double get percentage {
    if (total == 0) return 0;

    return (sent / total) * 100;
  }
}
