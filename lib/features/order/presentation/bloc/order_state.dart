import 'package:equatable/equatable.dart';

/// Minimal Order state for Step 1
class OrderState extends Equatable {
  const OrderState({
    this.isLoading = false,
    this.errorMessage,
    this.orders = const [],
    this.activeStatus,
  });

  final bool isLoading;
  final String? errorMessage;
  final List<dynamic> orders; // Step 1: placeholder until entity added
  final String? activeStatus; // null means All

  bool get isEmpty => orders.isEmpty && !isLoading && errorMessage == null;

  OrderState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<dynamic>? orders,
    String? activeStatus,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      orders: orders ?? this.orders,
      activeStatus: activeStatus ?? this.activeStatus,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, orders, activeStatus];
}
