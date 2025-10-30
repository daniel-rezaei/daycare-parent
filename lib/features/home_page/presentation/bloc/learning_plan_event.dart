//
// abstract class LearningPlanEvent {}
//
// class LoadPlans extends LearningPlanEvent {}

abstract class LearningPlanEvent {}

class LoadPlans extends LearningPlanEvent {
  final String ageGroupId; // 🟢 اضافه کردن پارامتر
  LoadPlans({required this.ageGroupId});
}
