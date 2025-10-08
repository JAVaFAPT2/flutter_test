import 'package:equatable/equatable.dart';
import 'order_tracking_status.dart';

class OrderTracking extends Equatable {
  const OrderTracking({
    required this.id,
    required this.orderId,
    required this.statuses,
    required this.currentStatusIndex,
  });

  final String id;
  final String orderId;
  final List<OrderTrackingStatus> statuses;
  final int currentStatusIndex; // 0-based index of current active status

  OrderTracking copyWith({
    String? id,
    String? orderId,
    List<OrderTrackingStatus>? statuses,
    int? currentStatusIndex,
  }) {
    return OrderTracking(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      statuses: statuses ?? this.statuses,
      currentStatusIndex: currentStatusIndex ?? this.currentStatusIndex,
    );
  }

  @override
  List<Object?> get props => [id, orderId, statuses, currentStatusIndex];
}
