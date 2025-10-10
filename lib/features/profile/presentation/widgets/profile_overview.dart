import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:vietnamese_fish_sauce_app/core/constants/app_assets.dart';
import 'package:vietnamese_fish_sauce_app/core/domain/entities/user.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/presentation/bloc/auth_bloc.dart';

/// Lightweight, view-only profile overview.
/// Reads user data from AuthBloc by default; can accept an override for testing.
class ProfileOverview extends StatelessWidget {
  const ProfileOverview({super.key, this.userOverride});

  final User? userOverride;

  @override
  Widget build(BuildContext context) {
    final user = userOverride ??
        context.select<AuthBloc, User?>(
          (b) => b.state.user,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Page label
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            'Trang thông tin tài khoản',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              color: Color(0xFF8E0306),
            ),
          ),
        ),

        // Welcome / edit info card
        _Header(user: user),

        const SizedBox(height: 24),

        // User info block with actions, closer to Figma
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    _InfoRow(
                        label: 'Tên người dùng:', value: user?.fullName ?? '—'),
                    const _InfoRow(label: 'ID Tài khoản:', value: '—'),
                    _InfoRow(
                        label: 'Số điện thoại:', value: user?.phone ?? '—'),
                    _InfoRow(label: 'Email:', value: user?.email ?? '—'),
                    _InfoRow(
                        label: 'Thông tin giao hàng:',
                        value: user?.address ?? '—'),
                  ],
                ),
              ),
              const Divider(height: 1),
              Builder(
                builder: (context) => _ActionTile(
                  iconPath: AppAssets.profileLockRed,
                  text: 'Đổi mật khẩu',
                  onTap: () => context.push('/change-password'),
                ),
              ),
              const Divider(height: 1),
              _ActionTile(
                iconPath: AppAssets.profileEmailEnvelope,
                text: 'Ý kiến phản hồi',
                onTap: () {},
              ),
              const Divider(height: 1),
              Builder(
                builder: (context) => _ActionTile(
                  iconPath: AppAssets.profileLogout,
                  text: 'Đăng xuất',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Đăng xuất'),
                        content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            child: const Text('Hủy'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                              context
                                  .read<AuthBloc>()
                                  .add(const AuthLogoutRequested());
                              context.go('/intro');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Đăng xuất'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Orders section
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
                child: Text(
                  'Đơn mua',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              const Divider(height: 1),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _OrderIcon(
                        label: 'Chờ xác nhận',
                        path: AppAssets.orderStatusPending,
                        width: 23),
                    _OrderIcon(
                        label: 'Chờ lấy hàng',
                        path: AppAssets.orderStatusPickup,
                        width: 17),
                    _OrderIcon(
                        label: 'Đang giao hàng',
                        path: AppAssets.orderStatusShipping,
                        width: 34),
                    _OrderIcon(
                        label: 'Đã giao hàng',
                        path: AppAssets.orderStatusDelivered,
                        width: 20),
                    _OrderIcon(
                        label: 'Đã hủy',
                        path: AppAssets.orderStatusCancelled,
                        width: 19),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Support section
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
                child: Text(
                  'Hỗ trợ',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              const Divider(height: 1),
              Builder(
                builder: (context) => _SupportTile(
                  text: 'Liên hệ trợ giúp tư vấn',
                  onTap: () => context.push('/customer-support'),
                ),
              ),
              const Divider(height: 1),
              Builder(
                builder: (context) => _SupportTile(
                  text: 'Thông tin về MGF',
                  onTap: () => context.push('/customer-support'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: const BoxDecoration(
              color: Color(0xFF900407),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: Image.asset(
                  AppAssets.profileAvatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Xin chào, ',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: user?.fullName ?? 'Nguyen Van A',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      'Chỉnh sửa thông tin',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Image.asset(AppAssets.profileEditPencil,
                        width: 10, height: 12),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Legacy rows/cards kept during earlier iterations have been replaced by the
// Figma-accurate sections below. They were removed to avoid lints.

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.iconPath, required this.text, this.onTap});
  final String iconPath;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Image.asset(iconPath,
                width: 15,
                height: 15,
                opacity: const AlwaysStoppedAnimation(0.9)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 16, color: Color(0xFF8A8A8A)),
          ],
        ),
      ),
    );
  }
}

class _OrderIcon extends StatelessWidget {
  const _OrderIcon(
      {required this.label, required this.path, required this.width});
  final String label;
  final String path;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(path,
            width: width, opacity: const AlwaysStoppedAnimation(0.5)),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 7,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _SupportTile extends StatelessWidget {
  const _SupportTile({required this.text, this.onTap});
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            // Keeping layout consistent with Figma, use default icons here
            const SizedBox(width: 15, height: 15),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 16, color: Color(0xFF8A8A8A)),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child, this.padding});
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFD9D9D9)),
      ),
      child: child,
    );
  }
}

// Centralized text styles if needed later
