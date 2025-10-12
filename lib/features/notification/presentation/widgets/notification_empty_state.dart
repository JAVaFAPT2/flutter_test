import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';

/// Widget for displaying empty state when no notifications exist
class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Không có thông báo nào hiển thị',
        style: TextStyle(
          fontSize: 10,
          color: AppColors.cProfileTextGray,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
