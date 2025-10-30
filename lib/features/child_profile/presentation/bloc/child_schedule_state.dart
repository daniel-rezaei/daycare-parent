
import '../../domain/entity/child_schedule_entity.dart';

abstract class ChildScheduleState {}

class ChildScheduleInitial extends ChildScheduleState {}

class ChildScheduleLoading extends ChildScheduleState {}

class ChildScheduleLoaded extends ChildScheduleState {
  final List<ChildScheduleEntity> events;
  ChildScheduleLoaded(this.events);
}

class ChildScheduleError extends ChildScheduleState {
  final String message;
  ChildScheduleError(this.message);
}
