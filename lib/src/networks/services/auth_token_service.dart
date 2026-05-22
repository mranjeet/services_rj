import '../../core/shared_pref_manager.dart';

/// ---------------------------------------------------------------------------
/// AuthTokenService – Singleton that persists & retrieves the auth token
/// via [SharedPrefManager].
/// ---------------------------------------------------------------------------
///
/// The token is obtained from your login API and stored locally.  It is then
/// automatically attached to every subsequent request by
/// [AuthTokenInterceptor] under the header key configured in [ApiConfig]
/// (defaults to `X_TOKEN`).
///
/// ---------------------------------------------------------------------------
/// Usage
/// ---------------------------------------------------------------------------
///
/// ```dart
/// // ── After successful login ──────────────────────────────────────────────
/// final response = await ApiClient.instance.request(
///   ApiRequest(endpoint: '/auth/login', method: ApiMethod.post,
///     body: {'email': '...', 'password': '...'}),
/// );
/// final token = response.data['token'] as String;
/// await AuthTokenService.instance.saveToken(token);
///
/// // ── All subsequent API calls will use the token automatically ─────────
///
/// // ── On logout ──────────────────────────────────────────────────────────
/// await AuthTokenService.instance.clearToken();
/// ```
///
/// ---------------------------------------------------------------------------
class AuthTokenService {
  AuthTokenService._();

  static final AuthTokenService instance = AuthTokenService._();

  // ---------------------------------------------------------------------------
  // Token – stored under SharedPrefKeys.userToken ("AUTH_TOKEN")
  // ---------------------------------------------------------------------------

  /// The stored auth token, or `null` if none has been saved yet.
  String? get token =>
      SharedPrefManager.getData<String>(SharedPrefKeys.userToken);

  /// Persist a new auth token (e.g. right after login).
  Future<bool> saveToken(String token) async {
    return SharedPrefManager.saveData(
      SharedPrefKeys.userToken,
      token,
    );
  }

  /// Remove the stored auth token (e.g. on logout).
  Future<void> clearToken() async {
    await SharedPrefManager.delete(SharedPrefKeys.userToken);
  }

  // ---------------------------------------------------------------------------
  // Convenience helpers
  // ---------------------------------------------------------------------------

  /// Whether a non‑empty token is currently stored.
  bool get hasToken => token != null && token!.isNotEmpty;

  /// Alias for [clearToken]; useful for a unified `logout()` flow.
  Future<void> logout() => clearToken();
}
