
import '../entities/meal_plan_entity.dart';

abstract class MealPlanRepository {
  Future<List<MealPlanEntity>> getMeals();
}