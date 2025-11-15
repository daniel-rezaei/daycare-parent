import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_form_usecase.dart';
import 'form_event.dart';
import 'form_state.dart';
import '../../../../home_page/presentation/bloc/child_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  final GetFormAssignmentsUseCase useCase;

  FormBloc(this.useCase) : super(FormInitial()) {
    on<LoadFormEvent>((event, emit) async {
      emit(FormLoading());
      try {
        final assignments = await useCase(
          childId: event.childId,
          childState: event.childState,
        );
        emit(FormLoaded(assignments));
      } catch (e) {
        emit(FormError(e.toString()));
      }
    });
  }
}
