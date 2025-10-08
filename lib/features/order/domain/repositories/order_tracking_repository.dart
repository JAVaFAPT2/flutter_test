import '../entities/order_tracking.dart';

abstract class OrderTrackingRepository {
  Future<OrderTracking?> getOrderTracking(String orderId);
}
