

import '../entity/child_schedule_entity.dart';

abstract class ChildScheduleRepository {
  Future<List<ChildScheduleEntity>> getSchedule({required String childId});
}