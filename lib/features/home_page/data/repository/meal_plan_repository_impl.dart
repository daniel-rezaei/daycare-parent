import '../../../../core/network/dio_client.dart';
import '../../domain/repositories/meal_plan_repository.dart';
import '../model/learning_plan/meal_plan_model.dart';

class MealPlanRepositoryImpl implements MealPlanRepository {
  final DioClient dioClient;

  MealPlanRepositoryImpl(this.dioClient);

  @override
  Future<List<MealPlanModel>> getMeals() async {
    final response = await dioClient.get('/items/Meal_Plan');
    final data = response.data['data'] as List;

    // تبدیل به مدل
    final allMeals = data.map((json) => MealPlanModel.fromJson(json)).toList();

    // فیلتر کردن فقط برای امروز
    final today = DateTime.now();
    final todayMeals = allMeals.where((meal) {
      final mealDate = DateTime.tryParse(meal.mealDate);
      if (mealDate == null) return false;
      return mealDate.year == today.year &&
          mealDate.month == today.month &&
          mealDate.day == today.day;
    }).toList();

    return todayMeals;
  }
}
