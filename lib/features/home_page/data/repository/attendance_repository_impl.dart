// import '../../../../core/network/dio_client.dart';
// import '../../domain/entities/attendance_entity.dart';
// import '../../domain/repositories/attendance_repository.dart';
// import '../model/attendance/attendance_model.dart';
//
// class AttendanceChildRepositoryImpl implements AttendanceChildRepository {
//   final DioClient dioClient;
//
//   AttendanceChildRepositoryImpl(this.dioClient);
//
//   @override
//   Future<List<AttendanceChildEntity>> getAttendance() async {
//     final today = DateTime.now().toUtc();
//     final todayStart = DateTime.utc(today.year, today.month, today.day);
//
//     // 1. سعی کن چک‌این امروز رو بگیری
//     var response = await dioClient.get(
//       '/items/Attendance_Child',
//       queryParameters: {
//         'filter[check_in_at][_gte]': todayStart.toIso8601String(),
//         'sort[]': '-check_in_at',
//         'limit': 1,
//       },
//     );
//
//     var data = response.data['data'] as List;
//
//     // 2. اگر خالی بود، آخرین check-out موجود رو بگیر
//     if (data.isEmpty) {
//       response = await dioClient.get(
//         '/items/Attendance_Child',
//         queryParameters: {
//           'filter[check_out_at][_is_not_null]': true,
//           'sort[]': '-check_out_at',
//           'limit': 1,
//         },
//       );
//       data = response.data['data'] as List;
//     }
//
//     return data.map((json) => AttendanceChildModel.fromJson(json)).toList();
//   }
//
// }
import 'package:flutter/cupertino.dart';

import '../../../../core/network/dio_client.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../model/attendance/attendance_model.dart';

class AttendanceChildRepositoryImpl implements AttendanceChildRepository {
  final DioClient dioClient;

  AttendanceChildRepositoryImpl(this.dioClient);

  @override
  Future<List<AttendanceChildEntity>> getAttendance(String childId) async { // 🔹 اضافه شد
    final response = await dioClient.get(
      '/items/Attendance_Child',
      queryParameters: {
        'filter[child_id][_eq]': childId, // 🔹 فقط داده‌های این کودک
        'sort[]': '-date_created',
        'limit': 10,
      },
    );

    final data = response.data['data'] as List;

    debugPrint("📡 Fetched attendance count: ${data.length} for childId: $childId");

    return data.map((json) => AttendanceChildModel.fromJson(json)).toList();
  }
}
