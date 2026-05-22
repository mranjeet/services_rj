import 'package:flutter/widgets.dart';

import '../networks/api_config.dart';
import '../networks/dio_service.dart';
import 'app_theme_controller.dart';
import 'shared_pref_manager.dart';

class AppInitializer {
  AppInitializer._();

  // ---------------------------------------------------------------------------
  // INITIALIZE
  // ---------------------------------------------------------------------------

  static Future<void> initialize({
    bool initializeSharedPref = true,

    bool initializeTheme = true,

    bool initializeNetwork = false,

    ApiConfig? apiConfig,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    // -----------------------------------------------------------------------
    // SHARED PREF
    // -----------------------------------------------------------------------

    if (initializeSharedPref) {
      await SharedPrefManager.initilization();
    }

    // -----------------------------------------------------------------------
    // THEME
    // -----------------------------------------------------------------------

    if (initializeTheme) {
      await AppThemeController.instance.initialize();
    }

    // -----------------------------------------------------------------------
    // NETWORK
    // -----------------------------------------------------------------------

    if (initializeNetwork) {
      if (apiConfig == null) {
        throw Exception('''
ApiConfig is required when initializeNetwork is true.

Example:

await AppInitializer.initialize(
  initializeNetwork: true,
  apiConfig: ApiConfig(
    baseUrl: 'https://api.example.com',
  ),
);
''');
      }

      DioService.instance.initialize(apiConfig);
    }
  }
}
