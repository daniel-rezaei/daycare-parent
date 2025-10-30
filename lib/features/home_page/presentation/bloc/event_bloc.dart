
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_event_usecase.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEventUseCase getEventUseCase;

  EventBloc(this.getEventUseCase) : super(EventInitial()) {
    on<LoadEvents>((event, emit) async {
      emit(EventLoading());
      try {
        final events = await getEventUseCase();
        emit(EventLoaded(events));
      } catch (e) {
        emit(EventError(e.toString()));
      }
    });
  }
}
