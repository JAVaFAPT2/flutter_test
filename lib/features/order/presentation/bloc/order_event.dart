import 'package:equatable/equatable.dart';

/// Order events for loading and filtering the orders list
abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class OrderLoadRequested extends OrderEvent {
  const OrderLoadRequested();
}

class OrderFilterChanged extends OrderEvent {
  const OrderFilterChanged(this.status);
  final String? status; // null means All

  @override
  List<Object?> get props => [status];
}

class OrderSearchQueryChanged extends OrderEvent {
  const OrderSearchQueryChanged(this.query);
  final String query;

  @override
  List<Object?> get props => [query];
}
