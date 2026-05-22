import 'callbacks/auth_callbacks.dart';
import 'callbacks/network_callbacks.dart';

class ApiConfig {
  const ApiConfig({
    required this.baseUrl,

    this.enableLogs = true,
    this.printLogs = false,
    this.connectTimeout = 30000,
    this.receiveTimeout = 30000,
    this.sendTimeout = 30000,

    this.defaultHeaders = const {},

    /// The HTTP header key used to send the auth token (e.g. `X_TOKEN`,
    /// `Authorization`).  When `null` the auth interceptor is skipped
    /// entirely.
    this.tokenHeaderKey,

    /// API endpoint for refreshing an expired token (e.g. `/auth/refresh`).
    /// Only used when [tokenHeaderKey] is set AND a 401 is received.
    this.refreshTokenEndpoint,

    this.onUnauthorized,
    this.onSessionExpired,
    this.onUserBanned,
    this.onError,
  });

  final String baseUrl;

  final bool enableLogs;

  final bool printLogs;

  final int connectTimeout;
  final int receiveTimeout;
  final int sendTimeout;

  final Map<String, dynamic> defaultHeaders;

  // ---------------------------------------------------------------------------
  // AUTH (optional – only applied when tokenHeaderKey is set)
  // ---------------------------------------------------------------------------

  /// The HTTP header key to send the auth token (e.g. `X_TOKEN`).
  /// When `null` the auth interceptor is not registered and no token
  /// header is added to requests.
  final String? tokenHeaderKey;

  /// Endpoint that returns a fresh token on 401 (e.g. `POST /auth/refresh`).
  /// The response **must** include a `token` field.
  final String? refreshTokenEndpoint;

  // ---------------------------------------------------------------------------
  // AUTH CALLBACKS
  // ---------------------------------------------------------------------------

  final OnUnauthorized? onUnauthorized;

  final OnSessionExpired? onSessionExpired;

  final OnUserBanned? onUserBanned;

  // ---------------------------------------------------------------------------
  // GLOBAL ERROR
  // ---------------------------------------------------------------------------

  final OnApiError? onError;
}
