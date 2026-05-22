import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void info(dynamic message) {
    if (kDebugMode) {
      log(message.toString(), name: 'INFO');
    }
  }

  static void error(dynamic message, {StackTrace? stackTrace}) {
    if (kDebugMode) {
      log(message.toString(), name: 'ERROR', stackTrace: stackTrace);
    }
  }

  static void warning(dynamic message) {
    if (kDebugMode) {
      log(message.toString(), name: 'WARNING');
    }
  }
}
