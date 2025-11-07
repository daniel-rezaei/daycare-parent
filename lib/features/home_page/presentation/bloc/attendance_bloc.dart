
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/get_attendance_usecase.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';


class AttendanceChildBloc extends Bloc<AttendanceChildEvent, AttendanceChildState> {
  final GetAttendanceChildUseCase useCase;

  AttendanceChildBloc(this.useCase) : super(AttendanceChildInitial()) {
    on<LoadAttendanceChild>((event, emit) async {
      emit(AttendanceChildLoading());
      try {
        final attendance = await useCase(event.childId); // 🔹 پاس دادن childId
        debugPrint("📦 Attendance data count: ${attendance.length}");
        for (var a in attendance) {
          debugPrint("checkInAt=${a.checkInAt}, checkOutAt=${a.checkOutAt}");
        }

        emit(AttendanceChildLoaded(attendance));
      } catch (e) {
        emit(AttendanceChildError(e.toString()));
      }
    });
  }
}
