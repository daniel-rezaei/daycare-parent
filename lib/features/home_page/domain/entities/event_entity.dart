
class EventEntity {
  final int? id;
  final String? title;
  final String? description;
  final String? eventType;
  final String? status;
  final DateTime? startAt;
  final DateTime? endAt;
  final bool allDay;

  EventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.eventType,
    required this.status,
    required this.startAt,
    required this.endAt,
    required this.allDay,
  });
}
