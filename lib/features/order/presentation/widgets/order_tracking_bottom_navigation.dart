import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_assets.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';

/// Reusable bottom navigation widget for order tracking page
/// Follows DRY principles by extracting common navigation structure
class OrderTrackingBottomNavigation extends StatelessWidget {
  const OrderTrackingBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 16),
      child: Row(
        children: [
          _buildNavigationButton(
            icon: AppAssets.orderTrackingOrderIcon,
            iconWidth: 51,
            iconHeight: 47,
            onTap: () => context.go('/orders'),
          ),
          const SizedBox(width: 16),
          _buildNavigationButton(
            icon: AppAssets.orderTrackingSupportIcon,
            iconWidth: 29,
            iconHeight: 40,
            onTap: () {
              // Navigate to support/chat when implemented
            },
          ),
          const SizedBox(width: 16),
          _buildReturnHomeButton(context),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required String icon,
    required double iconWidth,
    required double iconHeight,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cOrderTrackingBorder, width: 2),
          borderRadius: BorderRadius.circular(29),
        ),
        child: Center(
          child: Image.asset(
            icon,
            width: iconWidth,
            height: iconHeight,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildReturnHomeButton(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.go('/home'),
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: AppColors.cOrderTrackingBorder,
            borderRadius: BorderRadius.circular(55),
          ),
          child: const Center(
            child: Text(
              AppStrings.returnToHome,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
