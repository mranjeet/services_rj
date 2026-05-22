# SharedPrefManager

A lightweight, scalable, and production-ready SharedPreferences manager for Flutter.

Built with:
- ✅ Single initialization
- ✅ Singleton memory management
- ✅ Dynamic data retrieval
- ✅ Generic save support
- ✅ JSON serialization support
- ✅ Extensible key management
- ✅ Clean architecture
- ✅ Package-friendly API

---

# Features

✅ Save any supported SharedPreferences data type  
✅ Retrieve data dynamically or type-safe  
✅ Store JSON serializable objects  
✅ Single SharedPreferences initialization  
✅ Memory optimized  
✅ Extensible preference keys  
✅ Production-ready architecture  
✅ Lightweight and scalable

---

# Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  services_rj: latest_version
```

Then run:

```bash
flutter pub get
```

---
# Initialization

Initialize once before using the package.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefManager.initilization();

  runApp(const MyApp());
}
```

---

# Save Data

## Save String

```dart
await SharedPrefManager.saveData(
  SharedPrefKeys.userToken,
  "abc123",
);
```

---

## Save Bool

```dart
await SharedPrefManager.saveData(
  SharedPrefKeys.isDemoUser,
  true,
);
```

---

## Save Integer

```dart
await SharedPrefManager.saveData(
  "user_id",
  101,
);
```

---

## Save Double

```dart
await SharedPrefManager.saveData(
  "wallet_balance",
  999.50,
);
```

---

## Save List<String>

```dart
await SharedPrefManager.saveData(
  "categories",
  ["Sports", "News", "Movies"],
);
```

---

## Save JSON / Map

```dart
await SharedPrefManager.saveData(
  "user_data",
  {
    "id": 1,
    "name": "John",
    "email": "john@gmail.com",
  },
);
```

---

# Get Data

## Type-safe Retrieval

### String

```dart
final String? token =
    SharedPrefManager.getData<String>(
      SharedPrefKeys.userToken,
    );
```

---

### Bool

```dart
final bool? isDemo =
    SharedPrefManager.getData<bool>(
      SharedPrefKeys.isDemoUser,
    );
```

---

### Integer

```dart
final int? userId =
    SharedPrefManager.getData<int>(
      "user_id",
    );
```

---

### Double

```dart
final double? balance =
    SharedPrefManager.getData<double>(
      "wallet_balance",
    );
```

---

### List<String>

```dart
final List<String>? categories =
    SharedPrefManager.getData<List<String>>(
      "categories",
    );
```

---

### Map<String, dynamic>

```dart
final Map<String, dynamic>? userData =
    SharedPrefManager.getData<Map<String, dynamic>>(
      "user_data",
    );
```

---

# Dynamic Retrieval

You can retrieve values dynamically without specifying type.

```dart
final dynamic value =
    SharedPrefManager.getData(
      "custom_key",
    );
```

---

# Delete Single Key

```dart
await SharedPrefManager.delete(
  SharedPrefKeys.userToken,
);
```

---

# Clear All SharedPreferences Data

```dart
await SharedPrefManager.clearAllSharedPrefData();
```

---

# Check Key Exists

```dart
final bool exists =
    SharedPrefManager.containsKey(
      SharedPrefKeys.userToken,
    );
```

---

# Get All Keys

```dart
final keys = SharedPrefManager.getKeys();
```

---

# Reload SharedPreferences

```dart
await SharedPrefManager.reload();
```

---

# SharedPrefKeys

The package provides default keys.

```dart
abstract final class SharedPrefKeys {
  static const String userToken = "AUTH_TOKEN";

  static const String fullName = "FULL_NAME";

  static const String isDemoUser = "IS_DEMO_USER";

  static const String themeMode = "Theme_Mode";
}
```

---

# Create Custom Keys

You can create your own preference keys.

```dart
class AppPrefKeys extends SharedPrefKeys{
  static const String userId = "USER_ID";

  static const String languageCode = "LANGUAGE_CODE";

  static const String darkMode = "DARK_MODE";
}
```

Usage:

```dart
await SharedPrefManager.saveData(
  AppPrefKeys.userId,
  101,
);
```

---

# Store Custom Models

Convert your model into JSON.

## Model

```dart
class UserModel {
  final int id;
  final String name;

  UserModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
      id: json["id"],
      name: json["name"],
    );
  }
}
```

---

## Save Model

```dart
final user = UserModel(
  id: 1,
  name: "John",
);

await SharedPrefManager.saveData(
  "user",
  user.toJson(),
);
```

---

## Read Model

```dart
final json =
    SharedPrefManager.getData<Map<String, dynamic>>(
      "user",
    );

if (json != null) {
  final user = UserModel.fromJson(json);
}
```

---

# Supported Data Types

The package supports:

| Type | Supported |
|------|------------|
| String | ✅ |
| int | ✅ |
| double | ✅ |
| bool | ✅ |
| List<String> | ✅ |
| Map<String, dynamic> | ✅ (JSON Encoded) |

---

# Architecture Highlights

## Single Initialization

SharedPreferences instance is initialized only once.

This improves:
- performance
- memory usage
- startup optimization

---

## Singleton Memory Management

The package avoids repeated:

```dart
SharedPreferences.getInstance()
```

calls.

---

## Dynamic Retrieval

Supports:

```dart
getData<String>()
getData<bool>()
getData()
```

---

## Production Ready

Designed for:
- scalable Flutter apps
- enterprise architecture
- clean codebases

---

# Best Practices

✅ Initialize once in `main()`  
✅ Use centralized key management  
✅ Use typed retrieval whenever possible  
✅ Store only lightweight data in SharedPreferences

---

# Recommended Usage

Use SharedPreferences for:
- auth token
- app settings
- flags
- onboarding state
- theme mode
- lightweight cache

Avoid using it for:
- large offline databases
- huge JSON payloads
- relational data
---

# License

MIT License