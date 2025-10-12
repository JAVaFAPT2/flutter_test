import 'package:vietnamese_fish_sauce_app/features/notification/domain/repositories/notification_repository.dart';

/// Use case: Mark all notifications as read
class MarkAllRead {
  const MarkAllRead(this._repository);

  final NotificationRepository _repository;

  Future<void> call() async {
    return await _repository.markAllAsRead();
  }
}
