import 'package:vietnamese_fish_sauce_app/features/notification/domain/repositories/notification_repository.dart';

/// Use case: Get count of unread notifications
class GetUnreadCount {
  const GetUnreadCount(this._repository);

  final NotificationRepository _repository;

  Future<int> call() async {
    return await _repository.getUnreadCount();
  }
}
