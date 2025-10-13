import 'package:equatable/equatable.dart';

class Order extends Equatable {
  const Order({
    required this.id,
    required this.code,
    required this.createdAt,
    required this.status,
    required this.total,
    this.customerName,
  });

  final String id;
  final String code;
  final DateTime createdAt;
  final String status; // pending, confirmed, shipping, delivered, cancelled
  final double total;
  final String? customerName; // Optional customer name for search functionality

  @override
  List<Object?> get props => [id, code, createdAt, status, total, customerName];
}
