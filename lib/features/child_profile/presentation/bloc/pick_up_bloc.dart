
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent_app/features/child_profile/presentation/bloc/pick_up_state.dart';
import 'package:parent_app/features/child_profile/presentation/bloc/picke_up_event.dart';

import '../../domain/usecase/get_pickup_usecase.dart';

class PickupBloc extends Bloc<PickupEvent, PickupState> {
  final GetAuthorizedPickups getAuthorizedPickups;

  PickupBloc(this.getAuthorizedPickups) : super(PickupLoading()) {
    on<LoadAuthorizedPickups>((event, emit) async {
      emit(PickupLoading());
      try {
        final pickups = await getAuthorizedPickups(event.childId);
        emit(PickupLoaded(pickups));
      } catch (e) {
        emit(PickupError(e.toString()));
      }
    });
  }
}
