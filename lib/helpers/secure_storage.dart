import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Create storage
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // keys
  final String _isAuth = 'isAuth';
  final String _pkce = 'pkce';
  final String _authCode = 'authCode';
  final String _accessToken = 'accessToken';
  final String _refreshToken = 'refreshToken';

  // Authentication Status
  Future setAuthStatus(bool authState) async {
    await _storage.write(key: _isAuth, value: authState ? "true" : "false");
  }

  Future<bool> getAuthStatus() async {
    String s = await _storage.read(key: _isAuth) ?? "false";
    return s == "true" ? true : false;
  }

  // PKCE - CodeChallenge/Verifier
  Future setPkce(value) async {
    await _storage.write(key: _pkce, value: value);
  }

  Future<String> getPkce() async {
    return await _storage.read(key: _pkce) ?? "";
  }

  // AuthorizationCode received after oauth
  Future setAuthCode(value) async {
    await _storage.write(key: _authCode, value: value);
  }

  Future<String> getAuthCode() async {
    return await _storage.read(key: _authCode) ?? "";
  }

  // Oauth accessToken
  Future setAccessToken(value) async {
    await _storage.write(key: _accessToken, value: value);
  }

  Future<String> getAccessToken() async {
    return await _storage.read(key: _accessToken) ?? "";
  }

  // Oauth RefreshToken
  Future setRefreshToken(value) async {
    await _storage.write(key: _refreshToken, value: value);
  }

  Future<String> getRefreshToken() async {
    return await _storage.read(key: _refreshToken) ?? "";
  }

  // Clear SecureStorage
  Future clear() async => await _storage.deleteAll();
}
