
import '../../domain/entity/child_schedule_entity.dart';

class ChildScheduleModel extends ChildScheduleEntity {
  ChildScheduleModel({
    required super.scheduleType,
    required super.effectiveEnd,
    required super.effectiveStart,
    required super.childId,

  });

  factory ChildScheduleModel.fromJson(Map<String, dynamic> json) {
    return ChildScheduleModel(
        scheduleType: json['Schedule_Type'] ?? '',
        effectiveEnd: json['Effective_End'] ?? '',
        effectiveStart: json['Effective_Start'] ?? '',
        childId:json['child_id'] ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Schedule_Type': scheduleType,
      'Effective_End': effectiveEnd,
      'Effective_Start': effectiveStart,
      'child_id' : childId,

    };
  }
}