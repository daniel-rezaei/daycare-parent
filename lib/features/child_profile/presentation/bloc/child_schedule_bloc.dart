
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/child_schedule_usecase.dart';
import 'child_schedule_event.dart';
import 'child_schedule_state.dart';

class ChildScheduleBloc extends Bloc<ChildScheduleEvent, ChildScheduleState> {
  final GetChildScheduleUseCase getChildScheduleUseCase;

  ChildScheduleBloc(this.getChildScheduleUseCase) : super(ChildScheduleInitial()) {
    on<LoadChildSchedule>((event, emit) async {
      emit(ChildScheduleLoading());
      try {
        final childSchedule = await getChildScheduleUseCase(childId: event.childId);
        emit(ChildScheduleLoaded(childSchedule));
      } catch (e) {
        emit(ChildScheduleError(e.toString()));
      }
    });
  }
}
