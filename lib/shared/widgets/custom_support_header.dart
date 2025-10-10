import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';

/// Reusable header component for support and profile-related screens
///
/// Features:
/// - Back button with navigation
/// - Centered title text
/// - Profile avatar on the right
/// - Consistent styling with app design
///
/// Example usage:
/// ```dart
/// CustomSupportHeader(
///   title: 'Hỗ trợ khách hàng',
///   onBackPressed: () => context.pop(),
/// )
/// ```
class CustomSupportHeader extends StatelessWidget {
  const CustomSupportHeader({
    super.key,
    required this.title,
    this.onBackPressed,
    this.showAvatar = true,
  });

  /// Title text displayed in the center
  final String title;

  /// Optional custom back button handler (defaults to context.pop())
  final VoidCallback? onBackPressed;

  /// Whether to show the profile avatar (default: true)
  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top row with back button, logo, and avatar
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 20, top: 20),
          child: Row(
            children: [
              // Back button
              GestureDetector(
                onTap: onBackPressed ?? () => context.pop(),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Image.asset(
                    FigmaAssets.orderTrackingBackButton,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const Spacer(),

              // MGF Logo (centered)
              Image.asset(
                FigmaAssets.logoMgf,
                width: 82,
                height: 37,
                fit: BoxFit.contain,
              ),

              const Spacer(),

              // Profile avatar
              if (showAvatar)
                Container(
                  width: 43,
                  height: 43,
                  decoration: const BoxDecoration(
                    color: AppColors.cProfilePrimaryRed,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: ClipOval(
                      child: Image.asset(
                        FigmaAssets.avatarDefault,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(width: 43),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Centered title below logo
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.cProfileTitleRed,
            fontFamily: 'Poppins',
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
