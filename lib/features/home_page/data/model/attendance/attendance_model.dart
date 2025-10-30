


import '../../../domain/entities/attendance_entity.dart';

class AttendanceChildModel extends AttendanceChildEntity {
  AttendanceChildModel({
    required String? checkOutAt,
    required String? checkInAt,
    required String? checkInMethod,
    required String? checkOutMethod,
    required String? eventTime,
  }) : super(
    checkOutAt: checkOutAt,
    checkInAt: checkInAt,
    checkInMethod: checkInMethod,
    checkOutMethod: checkOutMethod,
      eventTime:eventTime,
  );

  factory AttendanceChildModel.fromJson(Map<String, dynamic> json) {
    return AttendanceChildModel(
      checkOutAt: json['check_out_at'] ?? '',
      checkInAt: json['check_in_at'] ?? '',
      checkInMethod: json['check_in_method'] ?? '',
      checkOutMethod: json['check_out_method'],
      eventTime: json['Event_Time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'check_out_at': checkOutAt,
      'check_in_at': checkInAt,
      'check_in_method': checkInMethod,
      'check_out_method': checkOutMethod,
      'Event_Time': eventTime,
    };
  }
}
