import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/domain/usecases/delete_all_notifications.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/domain/usecases/delete_notification.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/domain/usecases/get_notifications.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/domain/usecases/get_unread_count.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/domain/usecases/mark_all_read.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/domain/usecases/mark_notification_read.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/presentation/bloc/notification_event.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/presentation/bloc/notification_state.dart';

/// BLoC for notification feature
/// Handles all notification-related business logic
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({
    required GetNotifications getNotifications,
    required MarkNotificationRead markNotificationRead,
    required MarkAllRead markAllRead,
    required DeleteNotification deleteNotification,
    required DeleteAllNotifications deleteAllNotifications,
    required GetUnreadCount getUnreadCount,
  })  : _getNotifications = getNotifications,
        _markNotificationRead = markNotificationRead,
        _markAllRead = markAllRead,
        _deleteNotification = deleteNotification,
        _deleteAllNotifications = deleteAllNotifications,
        _getUnreadCount = getUnreadCount,
        super(const NotificationState()) {
    on<NotificationLoadRequested>(_onLoadRequested);
    on<NotificationMarkedAsRead>(_onMarkedAsRead);
    on<NotificationMarkAllReadRequested>(_onMarkAllReadRequested);
    on<NotificationDeleted>(_onDeleted);
    on<NotificationDeleteAllConfirmed>(_onDeleteAllConfirmed);
  }

  final GetNotifications _getNotifications;
  final MarkNotificationRead _markNotificationRead;
  final MarkAllRead _markAllRead;
  final DeleteNotification _deleteNotification;
  final DeleteAllNotifications _deleteAllNotifications;
  final GetUnreadCount _getUnreadCount;

  /// Handle load notifications event
  Future<void> _onLoadRequested(
    NotificationLoadRequested event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: NotificationStatus.loading));

    try {
      final notifications = await _getNotifications();
      final unreadCount = await _getUnreadCount();

      emit(
        state.copyWith(
          status: NotificationStatus.success,
          notifications: notifications,
          unreadCount: unreadCount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationStatus.error,
          errorMessage: 'Không thể tải thông báo: $e',
        ),
      );
    }
  }

  /// Handle mark as read event
  Future<void> _onMarkedAsRead(
    NotificationMarkedAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _markNotificationRead(event.id);

      // Reload notifications to update UI
      final notifications = await _getNotifications();
      final unreadCount = await _getUnreadCount();

      emit(
        state.copyWith(
          notifications: notifications,
          unreadCount: unreadCount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationStatus.error,
          errorMessage: 'Không thể đánh dấu đã đọc: $e',
        ),
      );
    }
  }

  /// Handle mark all read event
  Future<void> _onMarkAllReadRequested(
    NotificationMarkAllReadRequested event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _markAllRead();

      // Reload notifications to update UI
      final notifications = await _getNotifications();

      emit(
        state.copyWith(
          notifications: notifications,
          unreadCount: 0,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationStatus.error,
          errorMessage: 'Không thể đánh dấu tất cả đã đọc: $e',
        ),
      );
    }
  }

  /// Handle delete notification event
  Future<void> _onDeleted(
    NotificationDeleted event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _deleteNotification(event.id);

      // Reload notifications to update UI
      final notifications = await _getNotifications();
      final unreadCount = await _getUnreadCount();

      emit(
        state.copyWith(
          notifications: notifications,
          unreadCount: unreadCount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationStatus.error,
          errorMessage: 'Không thể xóa thông báo: $e',
        ),
      );
    }
  }

  /// Handle delete all confirmed event
  Future<void> _onDeleteAllConfirmed(
    NotificationDeleteAllConfirmed event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _deleteAllNotifications();

      // Clear state
      emit(
        state.copyWith(
          notifications: [],
          unreadCount: 0,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationStatus.error,
          errorMessage: 'Không thể xóa tất cả thông báo: $e',
        ),
      );
    }
  }
}
