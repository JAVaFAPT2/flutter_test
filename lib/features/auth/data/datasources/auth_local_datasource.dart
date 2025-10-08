import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../models/user_model.dart';

/// Local data source for authentication
/// Handles secure storage of tokens and user session
abstract class AuthLocalDataSource {
  /// Save auth token
  Future<void> saveToken(String token);

  /// Get auth token
  Future<String?> getToken();

  /// Remove auth token
  Future<void> removeToken();

  /// Save user session
  Future<void> saveUserSession(UserModel user);

  /// Get user session
  Future<UserModel?> getUserSession();

  /// Remove user session
  Future<void> removeUserSession();

  /// Check if authenticated
  Future<bool> hasToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  static const String _tokenKey = 'secure_token';
  static const String _userSessionKey = 'user_session';

  @override
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  @override
  Future<void> removeToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  @override
  Future<void> saveUserSession(UserModel user) async {
    final jsonString = jsonEncode(user.toJson());
    await _secureStorage.write(key: _userSessionKey, value: jsonString);
  }

  @override
  Future<UserModel?> getUserSession() async {
    final jsonString = await _secureStorage.read(key: _userSessionKey);
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> removeUserSession() async {
    await _secureStorage.delete(key: _userSessionKey);
  }

  @override
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}

