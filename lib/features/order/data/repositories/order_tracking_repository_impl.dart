import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order_tracking.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order_tracking_status.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/repositories/order_tracking_repository.dart';

class OrderTrackingRepositoryImpl implements OrderTrackingRepository {
  OrderTrackingRepositoryImpl(this._store);

  final FakeFirestore _store;

  @override
  Future<OrderTracking?> getOrderTracking(String orderId) async {
    final trackingData = await _store.getOrderTracking(orderId);

    if (trackingData == null) {
      return null;
    }

    // Convert string statuses to enum values
    final statusStrings = List<String>.from(trackingData['statuses'] ?? []);
    final statuses = statusStrings.map((status) {
      return OrderTrackingStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == status.toLowerCase(),
        orElse: () => OrderTrackingStatus.received,
      );
    }).toList();

    return OrderTracking(
      id: trackingData['id'] ?? 'tracking_$orderId',
      orderId: trackingData['orderId'] ?? orderId,
      statuses: statuses,
      currentStatusIndex: trackingData['currentStatusIndex'] ?? 0,
    );
  }
}
