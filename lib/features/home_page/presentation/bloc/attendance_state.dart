


import '../../domain/entities/attendance_entity.dart';

abstract class AttendanceChildState {}

class AttendanceChildInitial extends AttendanceChildState {}
class AttendanceChildLoading extends AttendanceChildState {}
class AttendanceChildLoaded extends AttendanceChildState {
  final List<AttendanceChildEntity> attendance;

  AttendanceChildLoaded(this.attendance);
}
class AttendanceChildError extends AttendanceChildState {
  final String message;
  AttendanceChildError(this.message);
}
