
import '../../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.eventType,
    required super.status,
    required super.startAt,
    required super.endAt,
    required super.allDay,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      eventType:json['event_type'] ?? '',
      status: json['status'] ?? '',
      startAt: DateTime.parse(json['start_at']),
      endAt: DateTime.parse(json['end_at']),
      allDay: json['all_day'] == false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'event_type' : eventType,
      'status': status,
      'start_at': startAt?.toIso8601String(),
      'end_at': endAt?.toIso8601String(),
      'all_day' : allDay,
    };
  }
}
