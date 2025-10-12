import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/domain/entities/notification.dart'
    as domain;

/// Widget for displaying a single notification item
class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    required this.notification,
    required this.onTap,
    super.key,
  });

  final domain.Notification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Message text
                Expanded(
                  child: Text(
                    notification.message,
                    style: TextStyle(
                      fontSize: 10,
                      color: notification.isRead
                          ? AppColors.cProfileTextGray
                          : Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Date and unread indicator
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatDate(notification.createdAt),
                      style: TextStyle(
                        fontSize: 8,
                        color: notification.isRead
                            ? AppColors.cProfileTextGray
                            : Colors.black,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.right,
                    ),
                    if (!notification.isRead) ...[
                      const SizedBox(height: 3),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF6B00), // Orange unread indicator
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Container(
              height: 1,
              color: AppColors.cProfileBorderGray,
            ),
          ),
        ],
      ),
    );
  }

  /// Format date to Vietnamese format (e.g., "Th 3", "CN", "20 Thg 10")
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hôm nay';
    } else if (difference.inDays == 1) {
      return 'Hôm qua';
    } else if (difference.inDays < 7) {
      // Day of week
      final weekday = _getVietnameseWeekday(date.weekday);
      return weekday;
    } else {
      // Full date
      return '${date.day} Thg ${date.month}';
    }
  }

  /// Get Vietnamese weekday name
  String _getVietnameseWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'Th 2';
      case 2:
        return 'Th 3';
      case 3:
        return 'Th 4';
      case 4:
        return 'Th 5';
      case 5:
        return 'Th 6';
      case 6:
        return 'Th 7';
      case 7:
        return 'CN';
      default:
        return '';
    }
  }
}
