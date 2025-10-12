import 'package:vietnamese_fish_sauce_app/features/notification/domain/repositories/notification_repository.dart';

/// Use case: Mark a single notification as read
class MarkNotificationRead {
  const MarkNotificationRead(this._repository);

  final NotificationRepository _repository;

  Future<void> call(String id) async {
    return await _repository.markAsRead(id);
  }
}
