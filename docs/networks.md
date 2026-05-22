# Network Module Documentation

## Overview

The `services_rj` network module is a production-ready, scalable, and reusable networking layer built on top of `dio`.

It is designed to handle:

* REST API requests
* Multipart file uploads
* Multiple file uploads
* File downloads
* Progress tracking
* Token refresh
* Authentication handling
* Retry mechanisms
* Request cancellation
* Global error handling
* Logging
* Custom interceptors

The architecture is extensible and suitable for:

* Small apps
* Enterprise applications
* Package ecosystems
* White-label applications

---

# Architecture

```text
ApiClient
   ↓
DioService
   ↓
Interceptors
   ↓
Response Handler
   ↓
Exception Handler
```

---

# Folder Structure

```text
network/
│
├── api_client.dart
├── api_config.dart
├── api_exception.dart
├── api_methods.dart
├── api_request.dart
├── api_response.dart
├── cancel_request.dart
├── dio_service.dart
├── request_type.dart
│
├── callbacks/
│   ├── auth_callbacks.dart
│   └── network_callbacks.dart
│
├── handlers/
│   ├── exception_handler.dart
│   └── response_handler.dart
│
├── interceptors/
│   ├── auth_interceptor.dart
│   ├── logger_interceptor.dart
│   ├── retry_interceptor.dart
│   └── error_interceptor.dart
│
└── models/
    ├── download_progress.dart
    └── upload_progress.dart
```

---

# Initialization

Initialize the network layer once before app startup.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioService.instance.initialize(
    ApiConfig(
      baseUrl: 'https://api.example.com',

      enableLogs: true,

      defaultHeaders: {
        'Accept': 'application/json',
      },

      onUnauthorized: () async {
        print('Unauthorized User');
      },

      onSessionExpired: () async {
        print('Session Expired');
      },

      onError: (message) {
        print(message);
      },
    ),
  );

  runApp(const MyApp());
}
```

---

# Request Types

The package supports three request types:

| Type                   | Purpose            |
| ---------------------- | ------------------ |
| `RequestType.normal`   | Standard APIs      |
| `RequestType.upload`   | File Upload APIs   |
| `RequestType.download` | File Download APIs |

---

# API Methods

Supported HTTP methods:

```dart
ApiMethod.get
ApiMethod.post
ApiMethod.put
ApiMethod.patch
ApiMethod.delete
```

---

# Basic GET API

```dart
final response =
    await ApiClient.instance.request(
  ApiRequest(
    endpoint: '/users',
    method: ApiMethod.get,
  ),
);

print(response.data);
```

---

# GET With Query Parameters

```dart
final response =
    await ApiClient.instance.request(
  ApiRequest(
    endpoint: '/users',
    method: ApiMethod.get,

    queryParameters: {
      'page': 1,
      'limit': 10,
    },
  ),
);
```

---

# POST API

```dart
final response =
    await ApiClient.instance.request(
  ApiRequest(
    endpoint: '/login',
    method: ApiMethod.post,

    body: {
      'email': 'demo@gmail.com',
      'password': '123456',
    },
  ),
);
```

---

# PUT API

```dart
final response =
    await ApiClient.instance.request(
  ApiRequest(
    endpoint: '/profile',
    method: ApiMethod.put,

    body: {
      'name': 'Ranjit',
    },
  ),
);
```

---

# PATCH API

```dart
final response =
    await ApiClient.instance.request(
  ApiRequest(
    endpoint: '/profile',
    method: ApiMethod.patch,

    body: {
      'is_active': true,
    },
  ),
);
```

---

# DELETE API

```dart
final response =
    await ApiClient.instance.request(
  ApiRequest(
    endpoint: '/account',
    method: ApiMethod.delete,
  ),
);
```

---

# Single File Upload

```dart
await ApiClient.instance.request(
  ApiRequest(
    endpoint: '/upload',

    method: ApiMethod.post,

    requestType: RequestType.upload,

    filePath: file.path,

    body: {
      'user_id': 1,
    },

    onUploadProgress: (progress) {
      print(progress.percentage);
    },
  ),
);
```

---

# Multiple File Upload

```dart
await ApiClient.instance.request(
  ApiRequest(
    endpoint: '/upload/multiple',

    method: ApiMethod.post,

    requestType: RequestType.upload,

    files: [
      file1,
      file2,
    ],

    body: {
      'folder': 'documents',
    },
  ),
);
```

---

# Download File

```dart
await ApiClient.instance.request(
  ApiRequest(
    endpoint: fileUrl,

    method: ApiMethod.get,

    requestType: RequestType.download,

    downloadSavePath:
        '/storage/emulated/0/Download/file.pdf',

    onDownloadProgress: (progress) {
      print(progress.percentage);
    },
  ),
);
```

---

# Request Cancellation

```dart
final cancelRequest =
    CancelRequest();

ApiClient.instance.request(
  ApiRequest(
    endpoint: '/users',

    method: ApiMethod.get,

    cancelRequest: cancelRequest,
  ),
);

cancelRequest.cancel();
```

---

# Custom Headers

```dart
await ApiClient.instance.request(
  ApiRequest(
    endpoint: '/profile',

    method: ApiMethod.get,

    headers: {
      'Authorization': 'Bearer token',
    },
  ),
);
```

---

# Authentication Interceptor

The package supports automatic token injection and token refresh.

Example:

```dart
DioService.instance.dio.interceptors.add(
  AuthInterceptor(
    getToken: () async {
      return SharedPrefManager.getData(
        'token',
      );
    },

    onRefreshToken: () async {
      return await refreshToken();
    },
  ),
);
```

---

# Global Error Handling

You can globally handle:

* Unauthorized users
* Session expiry
* User banned
* Validation errors
* API failures

Example:

```dart
ApiConfig(
  onUnauthorized: () async {
    print('Unauthorized');
  },

  onError: (message) {
    print(message);
  },
)
```

---

# Handling Exceptions

```dart
try {
  final response =
      await ApiClient.instance.request(
    ApiRequest(
      endpoint: '/users',
      method: ApiMethod.get,
    ),
  );
} on ApiException catch (e) {
  print(e.message);

  if (e.isUnauthorized) {
    print('Unauthorized');
  }

  if (e.isValidationError) {
    print('Validation Error');
  }
}
```

---

# Upload Progress

```dart
onUploadProgress: (progress) {
  print(progress.sent);
  print(progress.total);
  print(progress.percentage);
}
```

---

# Download Progress

```dart
onDownloadProgress: (progress) {
  print(progress.received);
  print(progress.total);
  print(progress.percentage);
}
```

---

# Retry Support

You can add custom retry interceptors.

Example scenarios:

* Timeout retry
* No internet retry
* Automatic retry after token refresh

---

# Logging

Enable logs during development.

```dart
ApiConfig(
  enableLogs: true,
)
```

Disable logs in production.

```dart
ApiConfig(
  enableLogs: false,
)
```

---

# Best Practices

## Recommended

✅ Initialize once
✅ Use interceptors
✅ Keep UI outside network layer
✅ Handle exceptions globally
✅ Use request cancellation for long APIs
✅ Use upload/download progress callbacks
✅ Use token refresh interceptor

---

## Avoid

❌ Navigation inside network layer
❌ Dialogs inside network layer
❌ Context usage inside API client
❌ Multiple Dio instances everywhere
❌ Business logic inside interceptors

---

# Production Recommendations

Recommended additional enhancements:

* Cache interceptor
* Offline queue
* Request deduplication
* Background sync
* Certificate pinning
* Request encryption
* Analytics interceptor
* Performance monitoring
* API mocking support

---

# Example Complete Flow

```dart
final response =
    await ApiClient.instance.request(
  ApiRequest(
    endpoint: '/login',

    method: ApiMethod.post,

    body: {
      'email': email,
      'password': password,
    },
  ),
);

final token =
    response.data['token'];

await SharedPrefManager.saveData(
  'token',
  token,
);
```

---

# Why This Architecture?

This architecture is:

✅ Scalable
✅ Reusable
✅ Enterprise Ready
✅ Package Friendly
✅ Extensible
✅ Testable
✅ Clean Architecture Compatible
✅ Production Ready

It is designed to support long-term Flutter application growth without major rewrites.
