import 'package:vietnamese_fish_sauce_app/features/notification/domain/repositories/notification_repository.dart';

/// Use case: Delete all notifications
class DeleteAllNotifications {
  const DeleteAllNotifications(this._repository);

  final NotificationRepository _repository;

  Future<void> call() async {
    return await _repository.deleteAllNotifications();
  }
}
