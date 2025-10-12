import 'package:vietnamese_fish_sauce_app/features/notification/data/datasources/notification_local_datasource.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/domain/entities/notification.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/domain/repositories/notification_repository.dart';

/// Implementation of notification repository
/// Delegates to local data source
class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._localDataSource);

  final NotificationLocalDataSource _localDataSource;

  @override
  Future<List<Notification>> getNotifications() async {
    try {
      return await _localDataSource.getNotifications();
    } catch (e) {
      throw Exception('Repository: Failed to get notifications - $e');
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    try {
      await _localDataSource.markAsRead(id);
    } catch (e) {
      throw Exception('Repository: Failed to mark notification as read - $e');
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      await _localDataSource.markAllAsRead();
    } catch (e) {
      throw Exception(
          'Repository: Failed to mark all notifications as read - $e');
    }
  }

  @override
  Future<void> deleteNotification(String id) async {
    try {
      await _localDataSource.deleteNotification(id);
    } catch (e) {
      throw Exception('Repository: Failed to delete notification - $e');
    }
  }

  @override
  Future<void> deleteAllNotifications() async {
    try {
      await _localDataSource.deleteAllNotifications();
    } catch (e) {
      throw Exception('Repository: Failed to delete all notifications - $e');
    }
  }

  @override
  Future<int> getUnreadCount() async {
    try {
      return await _localDataSource.getUnreadCount();
    } catch (e) {
      throw Exception('Repository: Failed to get unread count - $e');
    }
  }
}
