# services_rj

A lightweight yet scalable Flutter utility package providing:

- Smart SharedPreferences management
- Dynamic Theme Management
- Responsive utilities
- Snackbar & Dialog helpers
- Validators
- Debouncer
- Connectivity helpers
- Reusable widgets
- Developer-friendly extensions

Designed for production-ready Flutter applications with minimal setup and maximum scalability.

---

# Features

✅ Persistent Theme Management  
✅ Light / Dark / System Theme Support  
✅ SharedPreferences Wrapper  
✅ Material 3 Support  
✅ Global Theme Configuration  
✅ Responsive Helpers  
✅ Snackbar Utilities  
✅ Dialog Utilities  
✅ Form Validators  
✅ Connectivity Helpers  
✅ Debouncer Utility  
✅ Reusable Widgets  
✅ Easy Initialization  
✅ Minimal Boilerplate  
✅ Scalable Architecture  

---

# Installation

Add dependency in `pubspec.yaml`

```yaml
dependencies:
  services_rj: latest_version
```

Then run:

```bash
flutter pub get
```

---

# Initialize Package

```dart
void main() async {
  await AppInitializer.initialize();

  runApp(const MyApp());
}
```

---

# MaterialApp Setup

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppThemeController.instance,
      builder: (_, __) {
        const config = AppThemeConfig(
          seedColor: Colors.deepPurple,
          borderRadius: 16,
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: AppThemeManager.lightTheme(
            config,
          ),

          darkTheme: AppThemeManager.darkTheme(
            config,
          ),

          themeMode:
              AppThemeController.instance
                  .themeMode,

          home: const HomePage(),
        );
      },
    );
  }
}
```

---

# Theme Management

## Toggle Theme

```dart
AppThemeController.instance.toggleTheme();
```

## Set Specific Theme

```dart
AppThemeController.instance.setThemeMode(
  ThemeMode.dark,
);
```

---

# Theme Configuration

```dart
const config = AppThemeConfig(
  seedColor: Colors.deepPurple,
  borderRadius: 20,
  useMaterial3: true,
);
```

## Available Configurations

| Property | Description |
|----------|-------------|
| seedColor | Primary application color |
| borderRadius | Global border radius |
| useMaterial3 | Enable Material 3 |
| fontFamily | Global font family |
| lightScaffoldColor | Scaffold color for light mode |
| darkScaffoldColor | Scaffold color for dark mode |

---

# Shared Preference Manager

## Save Data

```dart
await SharedPrefManager.saveData(
  'token',
  'abc123',
);
```

## Get Data

```dart
final token =
    SharedPrefManager.getData<String>(
  'token',
);
```

## Delete Data

```dart
await SharedPrefManager.delete(
  'token',
);
```

---

# Snackbar Utility

## Success Snackbar

```dart
AppSnackbar.success(
  context,
  'Login Successful',
);
```

## Error Snackbar

```dart
AppSnackbar.error(
  context,
  'Something went wrong',
);
```

---

# Dialog Utility

## Show Loading

```dart
await AppDialogs.showLoading(
  context,
);
```

## Show Message

```dart
await AppDialogs.showMessage(
  context,
  title: 'Success',
  message: 'Profile Updated',
);
```

---

# Validators

## Email Validator

```dart
validator: AppValidators.email,
```

## Password Validator

```dart
validator: AppValidators.password,
```

## Required Field Validator

```dart
validator: AppValidators.requiredField,
```

---

# Responsive Helpers

```dart
AppResponsive.isMobile(context)

AppResponsive.isTablet(context)

AppResponsive.isDesktop(context)
```

---

# Extensions

```dart
context.theme

context.colors

context.textTheme

context.isDarkMode

context.screenWidth

context.screenHeight
```

---

# Debouncer

```dart
final debouncer = AppDebouncer();

debouncer.run(() {
  print('Search API Call');
});
```

---

# Connectivity

## Check Internet

```dart
final hasInternet =
    await AppConnectivity.hasInternet();
```

## Listen Connectivity

```dart
AppConnectivity.stream.listen((event) {
  print(event);
});
```

---

# Widgets

## ThemeModeSwitcher

```dart
const ThemeModeSwitcher()
```

## PrimaryLoader

```dart
const PrimaryLoader()
```

## AppScaffold

```dart
AppScaffold(
  body: YourWidget(),
)
```

---

# Architecture

```text
lib/
 ├── services_rj.dart
 │
 └── src
      ├── core
      │    ├── shared_pref_manager.dart
      │    ├── app_theme_manager.dart
      │    ├── app_theme_config.dart
      │    ├── app_theme_controller.dart
      │    ├── app_extensions.dart
      │    ├── app_dialogs.dart
      │    ├── app_snackbar.dart
      │    ├── app_logger.dart
      │    ├── app_responsive.dart
      │    ├── app_validators.dart
      │    ├── app_debouncer.dart
      │    ├── app_connectivity.dart
      │    └── app_initializer.dart
      │
      └── widgets
           ├── theme_mode_switcher.dart
           ├── primary_loader.dart
           └── app_scaffold.dart
```

---

# Philosophy

`services_rj` is built with the following principles:

- Minimal Boilerplate
- Production Ready
- Highly Scalable
- Clean APIs
- Modular Architecture
- Developer Friendly
- Ecosystem Compatible
- Easy Maintenance

---

# Future Roadmap

- Localization Manager
- Dynamic Runtime Themes
- App Router Helpers
- BottomSheet Utilities
- Secure Storage Support
- Reusable UI Components
- API Interceptors
- Logging Dashboard

---

# Contributing

Contributions are welcome.

Feel free to open issues and pull requests.

---

# License

MIT License