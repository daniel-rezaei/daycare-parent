
import '../entity/notification_entity.dart';
import '../repository/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  Future<List<NotificationEntity>> call(String childId) async {
    return repository.getNotifications(childId: childId);
  }
}
