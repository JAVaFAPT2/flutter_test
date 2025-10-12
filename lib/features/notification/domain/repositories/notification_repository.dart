import 'package:vietnamese_fish_sauce_app/features/notification/domain/entities/notification.dart';

/// Repository interface for notification operations
/// Following Repository Pattern for Clean Architecture
abstract class NotificationRepository {
  /// Get all notifications ordered by creation date (newest first)
  Future<List<Notification>> getNotifications();

  /// Mark a single notification as read
  Future<void> markAsRead(String id);

  /// Mark all notifications as read
  Future<void> markAllAsRead();

  /// Delete a single notification by ID
  Future<void> deleteNotification(String id);

  /// Delete all notifications
  Future<void> deleteAllNotifications();

  /// Get count of unread notifications for badge display
  Future<int> getUnreadCount();
}
