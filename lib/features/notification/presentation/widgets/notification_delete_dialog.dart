import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';

/// Confirmation dialog for deleting all notifications
class NotificationDeleteDialog extends StatelessWidget {
  const NotificationDeleteDialog({
    required this.onConfirm,
    required this.onCancel,
    super.key,
  });

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Shadow overlay
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.45),
          ),
        ),
        // Dialog content
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(bottom: 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(29),
                topRight: Radius.circular(29),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 45),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    'Xóa hết tất cả thông báo?',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  const Text(
                    'Các thông báo sẽ bị xóa vĩnh viễn',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.cProfileTextGray,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Delete button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cProfilePrimaryRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(272),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Xóa tất cả',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                  // Cancel button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cProfileBorderGray,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(272),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Giữ lại tất cả',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
