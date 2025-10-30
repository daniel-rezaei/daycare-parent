


import '../../domain/entities/learing_plan_entities.dart';

abstract class LearningPlanState {}

class LearningPlanInitial extends LearningPlanState {}

class LearningPlanLoading extends LearningPlanState {}

class LearningPlanLoaded extends LearningPlanState {
  final List<LearningPlanEntity> categories; // ✅ این فیلد را اضافه کن
  LearningPlanLoaded(this.categories);
}

class LearningPlanError extends LearningPlanState {
  final String message;
  LearningPlanError(this.message);
}
