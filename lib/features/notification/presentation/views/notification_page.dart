import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/core/di/injection_container.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/bottom_navigation.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/presentation/bloc/notification_event.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/presentation/bloc/notification_state.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/presentation/widgets/notification_delete_dialog.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/presentation/widgets/notification_empty_state.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/presentation/widgets/notification_list_item.dart';

/// Notification page matching Figma design (node 1-748, 1-805, 1-781)
/// Vietnamese fish sauce e-commerce app
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static const String routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<NotificationBloc>()..add(const NotificationLoadRequested()),
      child: const _NotificationView(),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if (state.status == NotificationStatus.error) {
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
                    child: Column(
                      children: [
                        // Header with title and delete button
                        _buildHeader(context),

                        const SizedBox(height: 10),

                        // Notification list
                        Expanded(
                          child: _buildNotificationList(),
                        ),
                      ],
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 31),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            // Back button
            GestureDetector(
              onTap: () => context.pop(),
              child: Image.asset(
                'assets/figma_exports/7cce197f9a05ae313b091174c27d09903dc71f0c.png',
                width: 48,
                height: 48,
              ),
            ),
            // Title
            const Expanded(
              child: Center(
                child: Text(
                  'Thông báo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.cProfileTitleRed,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            // Delete all button
            BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                // Show delete button only if there are notifications
                if (state.notifications.isEmpty) {
                  return const SizedBox(width: 48);
                }

                return GestureDetector(
                  onTap: () => _showDeleteDialog(context),
                  child: Image.asset(
                    'assets/figma_exports/945017ced91ac90b97106e1ea9292d9fa6ca6d75.png',
                    width: 26,
                    height: 26,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state.status == NotificationStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.cProfilePrimaryRed,
            ),
          );
        }

        if (state.notifications.isEmpty) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 42),
            padding: const EdgeInsets.symmetric(vertical: 96),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.cProfileBorderGray),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const NotificationEmptyState(),
          );
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 42),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.cProfileBorderGray),
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              final notification = state.notifications[index];
              return NotificationListItem(
                notification: notification,
                onTap: () {
                  // Mark as read when tapped
                  if (!notification.isRead) {
                    context
                        .read<NotificationBloc>()
                        .add(NotificationMarkedAsRead(notification.id));
                  }
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (dialogContext) {
        return NotificationDeleteDialog(
          onConfirm: () {
            context
                .read<NotificationBloc>()
                .add(const NotificationDeleteAllConfirmed());
            Navigator.of(dialogContext).pop();
          },
          onCancel: () {
            Navigator.of(dialogContext).pop();
          },
        );
      },
    );
  }
}
