import '../../../../core/network/dio_client.dart';
import '../../domain/entity/notification_entity.dart';
import '../../domain/repository/notification_repository.dart';
import '../model/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final DioClient dioClient;

  NotificationRepositoryImpl(this.dioClient);

  @override
  Future<List<NotificationEntity>> getNotifications({required String childId}) async {

    final response = await dioClient.get('/items/notifications');

    final allNotifications = (response.data['data'] as List)
        .map((json) => NotificationModel.fromJson(json))
        .toList();


    final filteredNotifications = allNotifications
        .where((notif) => notif.childId?.toString() == childId)
        .toList();

    return filteredNotifications;
  }
}
