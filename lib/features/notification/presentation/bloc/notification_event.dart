
abstract class NotificationEvent {}

class LoadNotificationsEvent extends NotificationEvent {
  final String childId;
  LoadNotificationsEvent(this.childId);
}
