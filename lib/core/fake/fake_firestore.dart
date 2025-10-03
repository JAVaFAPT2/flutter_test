import 'dart:async';

/// Simple in-memory fake Firestore for local development.
/// Provides async methods and broadcast streams to mimic Firestore behaviors.
class FakeFirestore {
  FakeFirestore._internal();
  static final FakeFirestore instance = FakeFirestore._internal();

  // Collections
  final Map<String, Map<String, dynamic>> _products = {};
  final Map<String, Map<String, dynamic>> _users = {};
  final Map<String, Map<String, dynamic>> _orders = {};
  final Map<String, Map<String, dynamic>> _notifications = {};

  // Streams
  final StreamController<List<Map<String, dynamic>>> _productStream =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  final StreamController<List<Map<String, dynamic>>> _orderStream =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  final StreamController<List<Map<String, dynamic>>> _notificationStream =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  // Seed helpers
  Future<void> seedProducts(List<Map<String, dynamic>> products) async {
    for (final item in products) {
      final String id = item['id']?.toString() ?? _autoId();
      _products[id] = {...item, 'id': id};
    }
    _emitProducts();
  }

  Future<void> seedUsers(List<Map<String, dynamic>> users) async {
    for (final item in users) {
      final String id = item['id']?.toString() ?? _autoId();
      _users[id] = {...item, 'id': id};
    }
  }

  Future<void> seedNotifications(
      List<Map<String, dynamic>> notifications) async {
    for (final item in notifications) {
      final String id = item['id']?.toString() ?? _autoId();
      _notifications[id] = {...item, 'id': id};
    }
    _emitNotifications();
  }

  // Product APIs
  Future<List<Map<String, dynamic>>> getProducts({String? category}) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    final values = _products.values.toList();
    if (category == null) return values;
    return values.where((e) => e['category'] == category).toList();
  }

  Stream<List<Map<String, dynamic>>> watchProducts({String? category}) {
    return _productStream.stream.map((list) {
      if (category == null) return list;
      return list.where((e) => e['category'] == category).toList();
    });
  }

  Future<Map<String, dynamic>?> getProductById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return _products[id];
  }

  // Order APIs
  Future<String> createOrder(Map<String, dynamic> order) async {
    final String id = _autoId();
    _orders[id] = {
      ...order,
      'id': id,
      'createdAt': DateTime.now().toIso8601String()
    };
    _emitOrders();
    return id;
  }

  Future<List<Map<String, dynamic>>> getOrders({String? userId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    final values = _orders.values.toList()
      ..sort((a, b) => (b['createdAt'] ?? '').compareTo(a['createdAt'] ?? ''));
    if (userId == null) return values;
    return values.where((e) => e['userId'] == userId).toList();
  }

  Stream<List<Map<String, dynamic>>> watchOrders({String? userId}) {
    return _orderStream.stream.map((list) {
      if (userId == null) return list;
      return list.where((e) => e['userId'] == userId).toList();
    });
  }

  // Notification APIs
  Future<void> addNotification(Map<String, dynamic> notification) async {
    final String id = _autoId();
    _notifications[id] = {
      ...notification,
      'id': id,
      'createdAt': DateTime.now().toIso8601String(),
      'read': notification['read'] ?? false,
    };
    _emitNotifications();
  }

  Future<List<Map<String, dynamic>>> getNotifications({String? userId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final values = _notifications.values.toList()
      ..sort((a, b) => (b['createdAt'] ?? '').compareTo(a['createdAt'] ?? ''));
    if (userId == null) return values;
    return values.where((e) => e['userId'] == userId).toList();
  }

  Stream<List<Map<String, dynamic>>> watchNotifications({String? userId}) {
    return _notificationStream.stream.map((list) {
      if (userId == null) return list;
      return list.where((e) => e['userId'] == userId).toList();
    });
  }

  Future<void> markNotificationRead(String id) async {
    final n = _notifications[id];
    if (n != null) {
      _notifications[id] = {...n, 'read': true};
      _emitNotifications();
    }
  }

  // Private helpers
  void _emitProducts() =>
      _productStream.add(_products.values.toList(growable: false));
  void _emitOrders() =>
      _orderStream.add(_orders.values.toList(growable: false));
  void _emitNotifications() =>
      _notificationStream.add(_notifications.values.toList(growable: false));

  String _autoId() => DateTime.now().microsecondsSinceEpoch.toString();

  // Dispose for tests
  void dispose() {
    _productStream.close();
    _orderStream.close();
    _notificationStream.close();
  }
}
