


import '../../domain/entities/event_entity.dart';

abstract class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<EventEntity> events;
  EventLoaded(this.events);
}

class EventError extends EventState {
  final String message;
  EventError(this.message);
}
