import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/order/data/models/order_model.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order.dart'
    as domain;
import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order_tracking.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order_tracking_status.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(this._store);
  final FakeFirestore _store;

  @override
  Future<List<domain.Order>> getOrders({String? userId, String? status}) async {
    final maps = await _store.getOrders(userId: userId);
    final models = maps.map((e) => OrderModel.fromMap(e)).toList();
    var domainOrders = models.map((e) => e.toDomain()).toList();
    if (status != null && status.isNotEmpty) {
      domainOrders = domainOrders.where((o) => o.status == status).toList();
    }
    return domainOrders;
  }

  @override
  Future<domain.Order?> getOrderDetail(String id) async {
    final maps = await _store.getOrders();
    final map = maps.firstWhere(
      (e) => (e['id']?.toString() ?? '') == id,
      orElse: () => {},
    );
    if (map.isEmpty) return null;
    return OrderModel.fromMap(map).toDomain();
  }

  @override
  Future<OrderTracking?> getOrderTracking(String orderId) async {
    // Mock data - in real impl, fetch from API/DB
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network

    final statuses = OrderTrackingStatus.values.toList();
    const currentIndex =
        3; // Active: shipping (to match the screenshot comparison)

    return OrderTracking(
      id: 'tracking_$orderId',
      orderId: orderId,
      statuses: statuses,
      currentStatusIndex: currentIndex,
    );
  }
}
