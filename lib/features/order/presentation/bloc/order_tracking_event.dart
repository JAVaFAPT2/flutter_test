import 'package:equatable/equatable.dart';

abstract class OrderTrackingEvent extends Equatable {
  const OrderTrackingEvent();

  @override
  List<Object?> get props => [];
}

class LoadOrderTracking extends OrderTrackingEvent {
  const LoadOrderTracking({required this.orderId});

  final String orderId;

  @override
  List<Object?> get props => [orderId];
}
