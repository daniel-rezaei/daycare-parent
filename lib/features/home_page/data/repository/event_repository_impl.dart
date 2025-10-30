
import '../../../../core/network/dio_client.dart';
import '../../domain/repositories/event_repository.dart';
import '../model/learning_plan/event_model.dart';


class EventRepositoryImpl implements EventRepository {
  final DioClient dioClient;

  EventRepositoryImpl(this.dioClient);

  @override
  Future<List<EventModel>> getEvents() async {
    final response = await dioClient.get('/items/Events');
    final data = response.data['data'] as List;
    return data.map((json) => EventModel.fromJson(json)).toList();
  }
}
