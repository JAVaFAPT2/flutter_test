import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/presentation/bloc/auth_bloc.dart';

/// Custom logout confirmation dialog matching Figma design (node 1-499)
/// Vietnamese fish sauce e-commerce app
class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  /// Show the logout dialog
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const LogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 53.5), // (440-333)/2 = 53.5
      child: Container(
        width: 333,
        height: 153,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dialog content with proper spacing
            const SizedBox(height: 20),

            // Confirmation message
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Bạn chắc chắn muốn đăng xuất\nkhỏi tài khoản này?',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // Buttons row - using Flexible to prevent overflow
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Đăng xuất button (red)
                  Flexible(child: _buildLogoutButton(context)),

                  const SizedBox(width: 12),

                  // Ở lại button (gray)
                  Flexible(child: _buildStayButton(context)),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Build the logout button (red)
  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      height: 37,
      child: ElevatedButton(
        onPressed: () => _handleLogout(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cProfilePrimaryRed,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(272),
          ),
          elevation: 0,
          minimumSize: const Size(130, 37),
        ),
        child: const Text(
          'Đăng xuất',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  /// Build the stay button (gray)
  Widget _buildStayButton(BuildContext context) {
    return SizedBox(
      height: 37,
      child: ElevatedButton(
        onPressed: () => _handleStay(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFBBBBBB),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(272),
          ),
          elevation: 0,
          minimumSize: const Size(130, 37),
        ),
        child: const Text(
          'Ở lại',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  /// Handle logout action
  void _handleLogout(BuildContext context) {
    // Close dialog
    Navigator.of(context).pop();

    // Dispatch logout event to AuthBloc
    context.read<AuthBloc>().add(const AuthLogoutRequested());

    // Navigate to intro screen
    context.go('/intro');
  }

  /// Handle stay action
  void _handleStay(BuildContext context) {
    // Simply close the dialog
    Navigator.of(context).pop();
  }
}
