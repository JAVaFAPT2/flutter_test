import 'package:vietnamese_fish_sauce_app/features/notification/domain/entities/notification.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/domain/repositories/notification_repository.dart';

/// Use case: Get all notifications
/// Clean Architecture: Business logic encapsulated in use case
class GetNotifications {
  const GetNotifications(this._repository);

  final NotificationRepository _repository;

  Future<List<Notification>> call() async {
    return await _repository.getNotifications();
  }
}
