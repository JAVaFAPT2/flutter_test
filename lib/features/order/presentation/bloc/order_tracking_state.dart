import 'package:equatable/equatable.dart';
import '../../domain/entities/order_tracking.dart';

class OrderTrackingState extends Equatable {
  const OrderTrackingState({
    this.isLoading = false,
    this.errorMessage,
    this.orderTracking,
  });

  final bool isLoading;
  final String? errorMessage;
  final OrderTracking? orderTracking;

  OrderTrackingState copyWith({
    bool? isLoading,
    String? errorMessage,
    OrderTracking? orderTracking,
  }) {
    return OrderTrackingState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      orderTracking: orderTracking ?? this.orderTracking,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, orderTracking];
}
