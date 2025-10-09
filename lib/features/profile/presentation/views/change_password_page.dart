import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/core/di/injection_container.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_assets.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/presentation/bloc/change_password_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/bottom_navigation.dart';

/// Change Password page matching Figma design (node 1-590)
/// Vietnamese fish sauce e-commerce app
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  static const String routeName = '/change-password';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChangePasswordBloc>(),
      child: const _ChangePasswordView(),
    );
  }
}

class _ChangePasswordView extends StatefulWidget {
  const _ChangePasswordView();

  @override
  State<_ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<_ChangePasswordView> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    // Retrieve authenticated user id from AuthBloc (Clean: UI reads state, BLoC handles logic)
    final authUser = context.read<AuthBloc>().state.user;
    final userId = authUser?.id ?? 'anonymous';

    context.read<ChangePasswordBloc>().add(
          ChangePasswordSubmitted(
            userId: userId,
            oldPassword: _oldPasswordController.text,
            newPassword: _newPasswordController.text,
            confirmPassword: _confirmPasswordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state.status == ChangePasswordStatus.success) {
            _showSuccessDialog(context);
          } else if (state.status == ChangePasswordStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Có lỗi xảy ra'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Stack(
          children: [
            // Background - reuse global background asset
            Positioned.fill(
              child: Image.asset(
                FigmaAssets.background,
                fit: BoxFit.cover,
              ),
            ),

            // Content
            SafeArea(
              child: Column(
                children: [
                  // DRY header
                  const HomeAppBar(),

                  // Page content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Profile Card
                          _buildProfileCard(),

                          const SizedBox(height: 10),

                          // Title
                          _buildTitle(),

                          const SizedBox(height: 10),

                          // Password Fields
                          _buildPasswordFields(),

                          const SizedBox(height: 24),

                          // Submit Button
                          _buildSubmitButton(),

                          const SizedBox(height: 24),

                          // Support Section
                          _buildSupportSection(),

                          const SizedBox(height: 120), // space for bottom nav
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // DRY bottom navigation
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: HomeBottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSuccessDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0D6A2E), // dark green backdrop
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 32),
                SizedBox(width: 12),
                Flexible(
                  child: Text(
                    'Đổi mật khẩu thành công',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Auto close after 1.2s then pop screen
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).maybePop();
    if (!mounted) return;
    // After acknowledgement, follow Clean flow: reset BLoC state and navigate
    context.read<ChangePasswordBloc>().add(const ChangePasswordReset());
    context.pop();
  }

  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 42),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      height: 63,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.cProfileBorderGray),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          // Avatar
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
          ),
          const SizedBox(width: 14),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Xin chào, ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Nguyen Van A',
                        style: TextStyle(
                          color: AppColors.cProfileUserNameRed,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Text(
                      'Chỉnh sửa thông tin',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.cProfileTextGray,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(
                      AppAssets.profileEditPencil,
                      width: 10,
                      height: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(left: 43),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Đổi mật khẩu',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.cProfileTitleRed,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Column(
        children: [
          // Old Password
          _buildPasswordField(
            label: '*Mật khẩu cũ',
            controller: _oldPasswordController,
          ),
          const SizedBox(height: 9),
          // New Password
          _buildPasswordField(
            label: '*Mật khẩu mới',
            controller: _newPasswordController,
          ),
          const SizedBox(height: 9),
          // Confirm Password
          _buildPasswordField(
            label: '*Nhập lại mật khẩu mới',
            controller: _confirmPasswordController,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.cProfileTextGray,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 33,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.cProfileBorderGray),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: controller,
            obscureText: true,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
            decoration: const InputDecoration(
              hintText: '*********',
              hintStyle: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 9),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        final isLoading = state.status == ChangePasswordStatus.loading;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: SizedBox(
            width: double.infinity,
            height: 33,
            child: ElevatedButton(
              onPressed: isLoading ? null : _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cProfilePrimaryRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'ĐỔI MẬT KHẨU',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSupportSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 42),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.cProfileBorderGray),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hỗ trợ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 13),
          const Divider(height: 1, color: AppColors.cProfileBorderGray),
          const SizedBox(height: 7),
          Row(
            children: [
              Image.asset(
                AppAssets.orderTrackingSupportIcon,
                width: 11,
                height: 16,
              ),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  'Liên hệ trợ giúp tư vấn',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.cProfileTextGray,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const Text(
                '>',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.cProfileTextGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(
                  child: Text(
                    'i',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  'Thông tin về MGF',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.cProfileTextGray,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const Text(
                '>',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.cProfileTextGray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Bottom nav is provided by HomeBottomNavigation above
}
