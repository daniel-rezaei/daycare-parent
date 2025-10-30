
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/guardian_usecase.dart';
import 'guardian_event.dart';
import 'guardian_state.dart';

class GuardianBloc extends Bloc<GuardianEvent, GuardianState> {
  final GetPrimaryGuardiansUseCase useCase;

  GuardianBloc(this.useCase) : super(GuardianInitial()) {
    on<LoadPrimaryGuardians>((event, emit) async {
      emit(GuardianLoading());
      try {
        final guardians = await useCase(childId: event.childId);
        if (guardians.isEmpty) {
          emit(GuardianEmpty());
        } else {
          emit(GuardianLoaded(guardians));
        }
      } catch (e) {
        emit(GuardianError(e.toString()));
      }
    });
  }
}