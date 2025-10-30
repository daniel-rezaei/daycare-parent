
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_meal_plan_usecase.dart';
import 'meal_plan_event.dart';
import 'meal_plan_state.dart';

class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  final GetMealPlanUseCase useCase;

  MealPlanBloc(this.useCase) : super(MealPlanInitial()) {
    on<LoadMeals>((event, emit) async {
      emit(MealPlanLoading());
      try {
        final meals = await useCase();
        emit(MealPlanLoaded(meals));
      } catch (e) {
        emit(MealPlanError(e.toString()));
      }
    });
  }
}
