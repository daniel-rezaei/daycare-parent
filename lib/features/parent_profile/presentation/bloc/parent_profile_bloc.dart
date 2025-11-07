import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/features/parent_profile/presentation/bloc/parent_profile_event.dart';
import 'package:parent_app/features/parent_profile/presentation/bloc/parent_profile_state.dart';

import '../../../home_page/domain/repositories/parent_repository.dart';


class ParentProfileBloc extends Bloc<ParentProfileEvent, ParentProfileState> {
  final ParentRepository parentRepository;

  ParentProfileBloc(this.parentRepository) : super(ParentProfileInitial()) {
    on<LoadParentProfileEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadParentProfileEvent event, Emitter<ParentProfileState> emit) async {
    emit(ParentProfileLoading());

    try {
      final result = await parentRepository.getParentContactForCurrentUser(
        currentUserId: event.parentId,   // ✅ صحیح
        childId: null,                   // یا بزن event.childId
      );

      if (result == null) {
        emit(ParentProfileError("Parent not found"));
        return;
      }

      emit(ParentProfileLoaded(result));
    } catch (e) {
      emit(ParentProfileError(e.toString()));
    }
  }

}
