import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Abstract interface for secure storage operations
abstract class SecureStorage {
  /// Save a string value securely
  Future<void> setString(String key, String value);

  /// Get a string value securely
  Future<String?> getString(String key);

  /// Remove a key from secure storage
  Future<void> remove(String key);

  /// Clear all secure data
  Future<void> clear();

  /// Check if key exists in secure storage
  Future<bool> containsKey(String key);

  /// Get secure token
  Future<String?> getSecureToken();

  /// Save secure token
  Future<void> setSecureToken(String token);

  /// Get user session data
  Future<String?> getUserSession();

  /// Save user session data
  Future<void> setUserSession(String sessionData);
}

/// Implementation of secure storage using FlutterSecureStorage
class SecureStorageImpl implements SecureStorage {
  const SecureStorageImpl(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String?> getString(String key) async {
    return _storage.read(key: key);
  }

  @override
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _storage.containsKey(key: key);
  }

  @override
  Future<String?> getSecureToken() async {
    return _storage.read(key: 'secure_token');
  }

  @override
  Future<void> setSecureToken(String token) async {
    await _storage.write(key: 'secure_token', value: token);
  }

  @override
  Future<String?> getUserSession() async {
    return _storage.read(key: 'user_session');
  }

  @override
  Future<void> setUserSession(String sessionData) async {
    await _storage.write(key: 'user_session', value: sessionData);
  }
}
