import 'package:equatable/equatable.dart';

/// Base class for notification events
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

/// Event: Load all notifications
class NotificationLoadRequested extends NotificationEvent {
  const NotificationLoadRequested();
}

/// Event: Mark a single notification as read
class NotificationMarkedAsRead extends NotificationEvent {
  const NotificationMarkedAsRead(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// Event: Mark all notifications as read
class NotificationMarkAllReadRequested extends NotificationEvent {
  const NotificationMarkAllReadRequested();
}

/// Event: Delete a single notification
class NotificationDeleted extends NotificationEvent {
  const NotificationDeleted(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// Event: Request to delete all notifications (show confirmation)
class NotificationDeleteAllRequested extends NotificationEvent {
  const NotificationDeleteAllRequested();
}

/// Event: Confirm delete all notifications
class NotificationDeleteAllConfirmed extends NotificationEvent {
  const NotificationDeleteAllConfirmed();
}
