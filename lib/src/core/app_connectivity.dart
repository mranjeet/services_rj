import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class AppConnectivity {
  AppConnectivity._();

  static final Connectivity _connectivity = Connectivity();

  static Stream<List<ConnectivityResult>> get stream =>
      _connectivity.onConnectivityChanged;

  static Future<bool> hasInternet() async {
    final result = await _connectivity.checkConnectivity();

    return !result.contains(ConnectivityResult.none);
  }
}
