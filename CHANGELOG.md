## 1.0.0

* **Networking**: Added DioService with safe lazy initialization, `addInterceptor()`/`addInterceptors()` APIs, `printLogs` config flag, `AuthTokenService` for token persistence, and `AuthTokenInterceptor` with automatic 401 refresh+retry.

* **Theming**: Extended `AppThemeConfig` with separate `cardRadius`, background/surface colours, outlined button border, elevation, and per-button text styles. `AppThemeManager` now styles AppBar, BottomNavigation, Card, Elevated/Outlined/Text buttons, InputDecoration, Chip, Dialog, and Icon.

* **Widgets**: New `AppButtons` widget with `AppButtonType` enum, 8 named factory constructors, and full extensibility via `customBuilder` or subclassing.

* **Core**: `SharedPrefKeys` gains `refreshToken` key. `AppInitializer`, `AppThemeController`, and `SharedPrefManager` unchanged but fully integrated.

* **Docs**: Comprehensive README with quick start, feature walkthroughs, and a complete end-to-end example.