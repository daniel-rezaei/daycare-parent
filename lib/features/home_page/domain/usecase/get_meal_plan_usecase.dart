
import '../entities/meal_plan_entity.dart';
import '../repositories/meal_plan_repository.dart';

class GetMealPlanUseCase {
  final MealPlanRepository repository;

  GetMealPlanUseCase(this.repository);

  Future<List<MealPlanEntity>> call() async {
    return await repository.getMeals();
  }
}
