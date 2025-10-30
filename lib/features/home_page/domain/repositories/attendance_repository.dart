
import '../entities/attendance_entity.dart';

abstract class AttendanceChildRepository {
  Future<List<AttendanceChildEntity>> getAttendance();
}