abstract class ChildScheduleEvent {}

class LoadChildSchedule extends ChildScheduleEvent {
  final String childId;
  LoadChildSchedule(this.childId);
}