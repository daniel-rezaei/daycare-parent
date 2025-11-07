


import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceChildUseCase {
  final AttendanceChildRepository repository;

  GetAttendanceChildUseCase(this.repository);

  Future<List<AttendanceChildEntity>> call(String childId) async { // 🔹 childId اضافه شد
    return repository.getAttendance(childId); // 🔹 پاس دادن به Repository
  }
}
