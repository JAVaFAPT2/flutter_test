import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order.dart'
    as domain;
import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order_tracking.dart';

abstract class OrderRepository {
  Future<List<domain.Order>> getOrders({String? userId, String? status});
  Future<domain.Order?> getOrderDetail(String id);
  Future<OrderTracking?> getOrderTracking(String orderId);
}
