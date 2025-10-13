import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order.dart';

/// Interactive progress timeline widget showing order status progress
class OrderProgressTimeline extends StatelessWidget {
  const OrderProgressTimeline({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    final progressWidth = _getProgressWidth(order.status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: () => context.push('/order/${order.id}/tracking'),
        child: Column(
          children: [
            // Progress bar container
            Container(
              width: 325,
              height: 2,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(1),
              ),
              child: Stack(
                children: [
                  // Progress fill
                  Container(
                    width: progressWidth,
                    height: 2,
                    decoration: BoxDecoration(
                      color: _getProgressColor(order.status),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Status indicator dot
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _getProgressColor(order.status),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get progress width based on order status
  double _getProgressWidth(String status) {
    switch (status) {
      case 'pending':
        return 39; // 12% of 325px
      case 'confirmed':
        return 100; // 30.7% of 325px
      case 'shipping':
        return 164; // 50.5% of 325px
      case 'delivered':
        return 231; // 71% of 325px
      case 'cancelled':
        return 291; // 89.5% of 325px
      default:
        return 39;
    }
  }

  /// Get progress color based on order status
  Color _getProgressColor(String status) {
    switch (status) {
      case 'pending':
        return const Color(0xFFFF9800); // Orange
      case 'confirmed':
        return const Color(0xFF2196F3); // Blue
      case 'shipping':
        return const Color(0xFF9C27B0); // Purple
      case 'delivered':
        return const Color(0xFF4CAF50); // Green
      case 'cancelled':
        return const Color(0xFFF44336); // Red
      default:
        return const Color(0xFFFF9800);
    }
  }
}
