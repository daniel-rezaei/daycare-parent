import '../entity/child_schedule_entity.dart';
import '../repository/child_schedule_repository.dart';

class GetChildScheduleUseCase {
  final ChildScheduleRepository repository;

  GetChildScheduleUseCase(this.repository);

  Future<List<ChildScheduleEntity>> call({required String childId}) async {
    return await repository.getSchedule(childId: childId);
  }
}
