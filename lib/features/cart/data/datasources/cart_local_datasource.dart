import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';

/// Local data source for cart persistence
/// Uses SharedPreferences for storage
abstract class CartLocalDataSource {
  /// Get saved cart from local storage
  Future<CartModel?> getCart();

  /// Save cart to local storage
  Future<void> saveCart(CartModel cart);

  /// Clear cart from local storage
  Future<void> clearCart();

  /// Get last updated timestamp
  Future<DateTime?> getLastUpdated();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  CartLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  static const String _cartKey = 'cart_data';
  static const String _lastUpdatedKey = 'cart_last_updated';

  @override
  Future<CartModel?> getCart() async {
    try {
      final jsonString = _prefs.getString(_cartKey);
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return CartModel.fromJson(json);
    } catch (e) {
      // If deserialization fails, return null
      return null;
    }
  }

  @override
  Future<void> saveCart(CartModel cart) async {
    final jsonString = jsonEncode(cart.toJson());
    await _prefs.setString(_cartKey, jsonString);
    await _prefs.setString(
      _lastUpdatedKey,
      DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<void> clearCart() async {
    await _prefs.remove(_cartKey);
    await _prefs.remove(_lastUpdatedKey);
  }

  @override
  Future<DateTime?> getLastUpdated() async {
    final timestamp = _prefs.getString(_lastUpdatedKey);
    if (timestamp == null) return null;

    try {
      return DateTime.parse(timestamp);
    } catch (e) {
      return null;
    }
  }
}

