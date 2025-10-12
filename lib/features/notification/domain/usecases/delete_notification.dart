import 'package:vietnamese_fish_sauce_app/features/notification/domain/repositories/notification_repository.dart';

/// Use case: Delete a single notification
class DeleteNotification {
  const DeleteNotification(this._repository);

  final NotificationRepository _repository;

  Future<void> call(String id) async {
    return await _repository.deleteNotification(id);
  }
}
