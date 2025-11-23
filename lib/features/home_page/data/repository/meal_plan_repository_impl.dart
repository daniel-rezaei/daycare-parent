import 'package:intl/intl.dart';

import '../../../../core/network/dio_client.dart';
import '../../domain/repositories/meal_plan_repository.dart';
import '../model/learning_plan/meal_plan_model.dart';

class MealPlanRepositoryImpl implements MealPlanRepository {
  final DioClient dioClient;

  MealPlanRepositoryImpl(this.dioClient);

  @override
  Future<List<MealPlanModel>> getMeals() async {
    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final response = await dioClient.get(
      '/items/Meal_Plan',
      queryParameters: {
        'filter[Meal_Date][_eq]': todayStr,
        'filter[Meal_Type][_in]': 'am_snack,lunch,pm_snack',
      },
    );

    final data = response.data['data'] as List;

    return data.map((json) => MealPlanModel.fromJson(json)).toList();
  }
}
