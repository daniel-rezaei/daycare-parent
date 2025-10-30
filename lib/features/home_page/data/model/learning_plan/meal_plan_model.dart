
import '../../../domain/entities/meal_plan_entity.dart';

class MealPlanModel extends MealPlanEntity {
  MealPlanModel({
    required String mealName,
    required String mealType,
    required String mealDate,
    required List<String> ingredients,
    String? notes,
  }) : super(
    mealName: mealName,
    mealType: mealType,
    mealDate: mealDate,
    ingredients: ingredients,
    notes: notes,
  );

  factory MealPlanModel.fromJson(Map<String, dynamic> json) {
    return MealPlanModel(
      mealName: json['Meal_Name'] ?? '',
      mealType: json['Meal_Type'] ?? '',
      mealDate: json['Meal_Date'] ?? '',
      ingredients: List<String>.from(json['Ingredients'] ?? []),
      notes: json['Notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Meal_Name': mealName,
      'Meal_Type': mealType,
      'Meal_Date': mealDate,
      'Ingredients': ingredients,
      'Notes': notes,
    };
  }
}
