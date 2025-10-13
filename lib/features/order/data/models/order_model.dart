import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order.dart'
    as domain;

class OrderModel {
  const OrderModel({
    required this.id,
    required this.code,
    required this.createdAt,
    required this.status,
    required this.total,
    this.customerName,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: (map['id'] ?? '').toString(),
      code: (map['code'] ?? '').toString(),
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      status: (map['status'] ?? 'pending').toString(),
      total: (map['total'] is num)
          ? (map['total'] as num).toDouble()
          : double.tryParse(map['total']?.toString() ?? '0') ?? 0.0,
      customerName: map['customerName']?.toString(),
    );
  }

  final String id;
  final String code;
  final DateTime createdAt;
  final String status;
  final double total;
  final String? customerName;

  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'createdAt': createdAt.toIso8601String(),
        'status': status,
        'total': total,
        'customerName': customerName,
      };

  domain.Order toDomain() => domain.Order(
        id: id,
        code: code,
        createdAt: createdAt,
        status: status,
        total: total,
        customerName: customerName,
      );
}
