
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/features/parent_profile/presentation/bloc/subsidy_event.dart';
import 'package:parent_app/features/parent_profile/presentation/bloc/subsidy_state.dart';

import '../../domain/usecases/get_subsidy_usecase.dart';

class SubsidyBloc extends Bloc<SubsidyEvent, SubsidyState> {
  final GetSubsidyUseCase getSubsidyUseCase;

  SubsidyBloc(this.getSubsidyUseCase) : super(SubsidyInitial()) {
    on<LoadSubsidyStatusEvent>(_onLoadSubsidyStatus);
  }

  Future<void> _onLoadSubsidyStatus(
      LoadSubsidyStatusEvent event, Emitter<SubsidyState> emit) async {
    emit(SubsidyLoading());
    try {
      final subsidies = await getSubsidyUseCase(event.contactId);
      final hasActive = subsidies.any((s) => s.isActive);
      emit(SubsidyLoaded(subsidies: subsidies, hasActive: hasActive));
    } catch (e) {
      emit(SubsidyError(e.toString()));
    }
  }
}
