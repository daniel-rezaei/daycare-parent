import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_child_usecase.dart';
import 'child_event.dart';
import 'child_state.dart';

class ChildBloc extends Bloc<ChildEvent, ChildState> {
  final GetChildDataUseCase useCase;

  ChildBloc(this.useCase) : super(ChildInitial()) {
    on<LoadChildData>((event, emit) async {
      emit(ChildLoading());
      try {
        final child = await useCase();
        if (child == null) {
          emit(ChildError('No data found'));
        } else {
          emit(ChildLoaded(child));
        }
      } catch (e) {
        emit(ChildError(e.toString()));
      }
    });

    // ✅ اضافه کردن event جدید برای تغییر آواتار
    on<UpdateSelectedAvatar>((event, emit) {
      if (state is ChildLoaded) {
        final current = state as ChildLoaded;
        emit(current.copyWith(selectedAvatar: event.avatar));
      }
    });
  }
}
