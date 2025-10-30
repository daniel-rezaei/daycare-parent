

import '../entities/learing_plan_entities.dart';

// abstract class LearningPlanRepository {
//   Future<List<LearningPlanEntity>> getPlan();
// }

abstract class LearningPlanRepository {
  Future<List<LearningPlanEntity>> getPlan({required String ageGroupId});
}
