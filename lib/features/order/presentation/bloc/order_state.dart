import 'package:equatable/equatable.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order.dart'
    as domain;

class OrderState extends Equatable {
  const OrderState({
    this.isLoading = false,
    this.errorMessage,
    this.orders = const [],
    this.activeStatus,
    this.searchQuery = '',
  });

  final bool isLoading;
  final String? errorMessage;
  final List<domain.Order> orders;
  final String? activeStatus; // null means All
  final String searchQuery;

  bool get isEmpty => orders.isEmpty && !isLoading && errorMessage == null;

  /// Filtered orders based on active status and search query
  List<domain.Order> get filteredOrders {
    var filtered = orders;

    // Filter by status
    if (activeStatus != null) {
      filtered =
          filtered.where((order) => order.status == activeStatus).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        final query = searchQuery.toLowerCase();
        return order.code.toLowerCase().contains(query) ||
            (order.customerName?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    return filtered;
  }

  OrderState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<domain.Order>? orders,
    String? activeStatus,
    String? searchQuery,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      orders: orders ?? this.orders,
      activeStatus: activeStatus ?? this.activeStatus,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, errorMessage, orders, activeStatus, searchQuery];
}
