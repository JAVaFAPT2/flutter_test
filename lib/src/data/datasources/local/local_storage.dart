import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';

/// Abstract interface for local storage operations
abstract class LocalStorage {
  /// Save a string value
  Future<void> setString(String key, String value);

  /// Get a string value
  Future<String?> getString(String key);

  /// Save an int value
  Future<void> setInt(String key, int value);

  /// Get an int value
  Future<int?> getInt(String key);

  /// Save a bool value
  Future<void> setBool(String key, bool value);

  /// Get a bool value
  Future<bool?> getBool(String key);

  /// Save a double value
  Future<void> setDouble(String key, double value);

  /// Get a double value
  Future<double?> getDouble(String key);

  /// Remove a key
  Future<void> remove(String key);

  /// Clear all data
  Future<void> clear();

  /// Check if key exists
  Future<bool> containsKey(String key);

  /// Get user token
  Future<String?> getToken();

  /// Save user token
  Future<void> setToken(String token);

  /// Get user data
  Future<String?> getUserData();

  /// Save user data
  Future<void> setUserData(String userData);

  /// Get cart data
  Future<String?> getCart();

  /// Save cart data
  Future<void> setCart(String cartData);

  /// Get favorite products
  Future<String?> getFavorites();

  /// Save favorite products
  Future<void> setFavorites(String favoritesData);
}

/// Implementation of local storage using SharedPreferences
class LocalStorageImpl implements LocalStorage {
  const LocalStorageImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  @override
  Future<double?> getDouble(String key) async {
    return _prefs.getDouble(key);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _prefs.containsKey(key);
  }

  @override
  Future<String?> getToken() async {
    return _prefs.getString(AppConstants.tokenKey);
  }

  @override
  Future<void> setToken(String token) async {
    await _prefs.setString(AppConstants.tokenKey, token);
  }

  @override
  Future<String?> getUserData() async {
    return _prefs.getString(AppConstants.userDataKey);
  }

  @override
  Future<void> setUserData(String userData) async {
    await _prefs.setString(AppConstants.userDataKey, userData);
  }

  @override
  Future<String?> getCart() async {
    return _prefs.getString(AppConstants.cartKey);
  }

  @override
  Future<void> setCart(String cartData) async {
    await _prefs.setString(AppConstants.cartKey, cartData);
  }

  @override
  Future<String?> getFavorites() async {
    return _prefs.getString(AppConstants.favoritesKey);
  }

  @override
  Future<void> setFavorites(String favoritesData) async {
    await _prefs.setString(AppConstants.favoritesKey, favoritesData);
  }
}
