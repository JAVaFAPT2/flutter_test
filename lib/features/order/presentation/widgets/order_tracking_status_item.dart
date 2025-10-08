import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';

/// Reusable widget for order tracking status items
/// Follows DRY principles by extracting common status item structure
class OrderTrackingStatusItem extends StatelessWidget {
  const OrderTrackingStatusItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.isCurrent,
  });

  final String title;
  final String subtitle;
  final bool isActive;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _getTitleColor(),
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.cOrderTrackingInactive,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Color _getTitleColor() {
    if (isCurrent) {
      return AppColors.cOrderTrackingActive;
    } else if (isActive) {
      return Colors.black;
    } else {
      return AppColors.cOrderTrackingInactive;
    }
  }
}
