import 'package:equatable/equatable.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/domain/entities/notification.dart';

/// Status of notification operations
enum NotificationStatus {
  initial,
  loading,
  success,
  error,
}

/// State for notification feature
class NotificationState extends Equatable {
  const NotificationState({
    this.status = NotificationStatus.initial,
    this.notifications = const [],
    this.unreadCount = 0,
    this.errorMessage,
  });

  final NotificationStatus status;
  final List<Notification> notifications;
  final int unreadCount;
  final String? errorMessage;

  /// Create a copy of this state with updated fields
  NotificationState copyWith({
    NotificationStatus? status,
    List<Notification>? notifications,
    int? unreadCount,
    String? errorMessage,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, notifications, unreadCount, errorMessage];
}
