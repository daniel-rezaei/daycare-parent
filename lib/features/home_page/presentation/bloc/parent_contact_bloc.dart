
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_parent_contact_usecase.dart';
import 'parent_contact_event.dart';
import 'parent_contact_state.dart';

class ParentContactBloc extends Bloc<ParentContactEvent, ParentContactState> {
  final GetParentContactUseCase useCase;

  ParentContactBloc(this.useCase) : super(ParentContactInitial()) {
    on<LoadParentContact>((event, emit) async {
      emit(ParentContactLoading());
      try {
        final contact = await useCase(
          currentUserId: event.currentUserId,
          childId: event.childId,
        );
        if (contact == null || contact.fullName.isEmpty) {
          emit(ParentContactEmpty());
        } else {
          emit(ParentContactLoaded(contact));
        }
      } catch (e) {
        emit(ParentContactError(e.toString()));
      }
    });
  }
}
