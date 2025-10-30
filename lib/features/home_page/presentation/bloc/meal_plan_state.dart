
import '../../domain/entities/meal_plan_entity.dart';

abstract class MealPlanState {}

class MealPlanInitial extends MealPlanState {}

class MealPlanLoading extends MealPlanState {}

class MealPlanLoaded extends MealPlanState {
  final List<MealPlanEntity> meals;
  MealPlanLoaded(this.meals);
}

class MealPlanError extends MealPlanState {
  final String message;
  MealPlanError(this.message);
}
