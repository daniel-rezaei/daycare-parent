//
//
// import '../entities/learing_plan_entities.dart';
// import '../repositories/learning_plan_repository.dart';
//
// class GetLearningPlanUseCase {
//   final LearningPlanRepository repository;
//
//   GetLearningPlanUseCase(this.repository);
//
//   Future<List<LearningPlanEntity>> call() async {
//     return await repository.getPlan();
//   }
// }

import '../entities/learing_plan_entities.dart';
import '../repositories/learning_plan_repository.dart';

class GetLearningPlanUseCase {
  final LearningPlanRepository repository;

  GetLearningPlanUseCase(this.repository);

  // 🟢 اضافه کردن پارامتر ageGroupId
  Future<List<LearningPlanEntity>> call({required String ageGroupId}) async {
    return await repository.getPlan(ageGroupId: ageGroupId);
  }
}
