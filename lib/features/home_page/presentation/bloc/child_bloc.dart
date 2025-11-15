// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/usecase/get_child_usecase.dart';
// import 'child_event.dart';
// import 'child_state.dart';
//
// class ChildBloc extends Bloc<ChildEvent, ChildState> {
//   final GetChildDataUseCase useCase;
//
//   ChildBloc(this.useCase) : super(ChildInitial()) {
//     on<LoadChildData>((event, emit) async {
//       emit(ChildLoading());
//       try {
//         final child = await useCase();
//         if (child == null) {
//           emit(ChildError('No data found'));
//         } else {
//           emit(ChildLoaded(child));
//         }
//       } catch (e) {
//         emit(ChildError(e.toString()));
//       }
//     });
//
//     // ✅ اضافه کردن event جدید برای تغییر آواتار
//     on<UpdateSelectedAvatar>((event, emit) {
//       if (state is ChildLoaded) {
//         final current = state as ChildLoaded;
//         emit(current.copyWith(selectedAvatar: event.avatar));
//       }
//     });
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_child_usecase.dart';
import 'child_event.dart';
import 'child_state.dart';

class ChildBloc extends Bloc<ChildEvent, ChildState> {
  final GetChildDataUseCase useCase;

  ChildBloc(this.useCase) : super(ChildInitial()) {
    on<LoadChildren>((event, emit) async {
      emit(ChildLoading());
      try {
        final children = await useCase(); // باید لیست بده
        if (children == null || children.isEmpty) {
          emit(ChildError('No children found'));
        } else {
          emit(ChildListLoaded(children));
        }
      } catch (e) {
        emit(ChildError(e.toString()));
      }
    });

    on<SelectChild>((event, emit) {
      if (state is ChildListLoaded) {
        final current = state as ChildListLoaded;
        // فقط یک state منتشر کن: لیست با selectedIndex جدید
        emit(current.copyWith(selectedIndex: event.index));
        // ✅ دیگر نیازی به ChildSelected جدا نیست
      }
    });

  }
}
