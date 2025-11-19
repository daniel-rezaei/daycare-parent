
import '../../../../core/network/dio_client.dart';
import '../../domain/repository/child_schedule_repository.dart';
import '../model/child_schedule_model.dart';

class ChildScheduleRepositoryImpl implements ChildScheduleRepository {
  final DioClient dioClient;

  ChildScheduleRepositoryImpl(this.dioClient);

  @override
  Future<List<ChildScheduleModel>> getSchedule({required String childId}) async {
    final response = await dioClient.get('/items/Child_Schedule', queryParameters: {
      'filter[child_id][_eq]': childId, // فیلتر فقط برای childId
    });
    final data = response.data['data'] as List;
    return data.map((json) => ChildScheduleModel.fromJson(json)).toList();
  }
}