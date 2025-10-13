import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/order_progress_timeline.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/order/${order.id}'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), // Light gray background
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Column(
          children: [
            // Order info row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.code,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4E3620),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatDate(order.createdAt),
                      style: const TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _StatusChip(status: order.status),
                    const SizedBox(height: 6),
                    Text(
                      _formatCurrency(order.total),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC80000),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Progress timeline
            OrderProgressTimeline(order: order),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';

  String _formatCurrency(double vnd) => '${vnd.toStringAsFixed(0)} đ';
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;
    switch (status) {
      case 'delivered':
        bg = const Color(0xFFE8F5E9);
        fg = const Color(0xFF2E7D32);
        break;
      case 'shipping':
        bg = const Color(0xFFE3F2FD);
        fg = const Color(0xFF1565C0);
        break;
      case 'cancelled':
        bg = const Color(0xFFFFEBEE);
        fg = const Color(0xFFC62828);
        break;
      default:
        bg = const Color(0xFFFFF8E1);
        fg = const Color(0xFFEF6C00);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(status, style: TextStyle(fontSize: 10, color: fg)),
    );
  }
}
