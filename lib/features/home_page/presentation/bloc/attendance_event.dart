abstract class AttendanceChildEvent {}

class LoadAttendanceChild extends AttendanceChildEvent {
  final String childId; // 🔹 اضافه شد
  LoadAttendanceChild(this.childId);
}
