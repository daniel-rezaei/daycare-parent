import 'package:flutter_bloc/flutter_bloc.dart';
import 'shared_media_event.dart';
import 'shared_media_state.dart';
import '../../domain/usecase/get_shared_media_usecase.dart';

class SharedMediaBloc extends Bloc<SharedMediaEvent, SharedMediaState> {
  final GetSharedMediaUseCase useCase;

  SharedMediaBloc(this.useCase) : super(SharedMediaInitial()) {
    on<LoadSharedMediaEvent>((event, emit) async {
      emit(SharedMediaLoading());
      try {
        final media = await useCase(childId: event.childId);
        emit(SharedMediaLoaded(media));
      } catch (e) {
        emit(SharedMediaError(e.toString()));
      }
    });
  }
}
