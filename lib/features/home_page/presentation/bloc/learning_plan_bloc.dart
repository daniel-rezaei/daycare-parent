//
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../domain/entities/learing_plan_entities.dart';
// import '../../domain/usecase/get_learning_plan_usecase.dart';
// import 'learning_plan_event.dart';
// import 'learning_plan_state.dart';
//
//
// class LearningPlanBloc extends Bloc<LearningPlanEvent, LearningPlanState> {
//   final GetLearningPlanUseCase useCase;
//
//   LearningPlanBloc(this.useCase) : super(LearningPlanInitial()) {
//     on<LoadPlans>((event, emit) async {
//       emit(LearningPlanLoading());
//       try {
//         final List<LearningPlanEntity> categories = await useCase();
//         emit(LearningPlanLoaded(categories));
//       } catch (e) {
//         emit(LearningPlanError(e.toString()));
//       }
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/learing_plan_entities.dart';
import '../../domain/usecase/get_learning_plan_usecase.dart';
import 'learning_plan_event.dart';
import 'learning_plan_state.dart';

class LearningPlanBloc extends Bloc<LearningPlanEvent, LearningPlanState> {
  final GetLearningPlanUseCase useCase;

  LearningPlanBloc(this.useCase) : super(LearningPlanInitial()) {
    on<LoadPlans>((event, emit) async {
      emit(LearningPlanLoading());
      try {
        // 🟢 ارسال ageGroupId به UseCase
        final List<LearningPlanEntity> categories = await useCase(ageGroupId: event.ageGroupId);
        emit(LearningPlanLoaded(categories));
      } catch (e) {
        emit(LearningPlanError(e.toString()));
      }
    });
  }
}

