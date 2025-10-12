import 'package:sqflite/sqflite.dart';
import 'package:vietnamese_fish_sauce_app/core/database/database_helper.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/data/models/notification_model.dart';

/// Local data source for notification operations using sqflite
abstract class NotificationLocalDataSource {
  /// Get all notifications ordered by creation date (newest first)
  Future<List<NotificationModel>> getNotifications();

  /// Mark a single notification as read
  Future<void> markAsRead(String id);

  /// Mark all notifications as read
  Future<void> markAllAsRead();

  /// Delete a single notification by ID
  Future<void> deleteNotification(String id);

  /// Delete all notifications
  Future<void> deleteAllNotifications();

  /// Get count of unread notifications
  Future<int> getUnreadCount();
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  NotificationLocalDataSourceImpl(this._databaseHelper);

  final DatabaseHelper _databaseHelper;

  static const String _tableName = 'notifications';

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        orderBy: 'created_at DESC',
      );

      return maps.map((map) => NotificationModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get notifications: $e');
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    try {
      final db = await _databaseHelper.database;
      await db.update(
        _tableName,
        {'is_read': 1},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      final db = await _databaseHelper.database;
      await db.update(
        _tableName,
        {'is_read': 1},
      );
    } catch (e) {
      throw Exception('Failed to mark all notifications as read: $e');
    }
  }

  @override
  Future<void> deleteNotification(String id) async {
    try {
      final db = await _databaseHelper.database;
      await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to delete notification: $e');
    }
  }

  @override
  Future<void> deleteAllNotifications() async {
    try {
      final db = await _databaseHelper.database;
      await db.delete(_tableName);
    } catch (e) {
      throw Exception('Failed to delete all notifications: $e');
    }
  }

  @override
  Future<int> getUnreadCount() async {
    try {
      final db = await _databaseHelper.database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $_tableName WHERE is_read = 0',
      );

      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      throw Exception('Failed to get unread count: $e');
    }
  }
}
