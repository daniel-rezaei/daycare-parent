
class MealPlanEntity {
  final String mealName;
  final String mealType;
  final String mealDate;
  final List<String> ingredients;
  final String? notes;

  MealPlanEntity({
    required this.mealName,
    required this.mealType,
    required this.mealDate,
    required this.ingredients,
    this.notes,
  });
}