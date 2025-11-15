import '../../../../../core/network/dio_client.dart';
import '../../../../home_page/presentation/bloc/child_state.dart';
import '../../domain/entity/form_entity.dart';
import '../../domain/repository/form_repository.dart';
import '../model/form_model.dart';

class FormRepositoryImpl implements FormRepository {
  final DioClient _dioClient;
  final Map<String, int>? uuidToNumericId; // mapping اختیاری از بیرون

  FormRepositoryImpl(this._dioClient, {this.uuidToNumericId});

  @override
  Future<List<FormAssignmentEntity>> getFormAssignments({
    required String childId,
    required ChildListLoaded childState,
  }) async {
    try {
      // 1️⃣ پیدا کردن numericChildId
      final numericChildId =
          uuidToNumericId?[childId] ?? childState.uuidToNumericId[childId];

      if (numericChildId == null) {
        print('❌ ChildId mapping not found for $childId');
        return [];
      }
      print('🔹 Selected child UUID: $childId');
      print('🔹 Numeric child ID: $numericChildId');

      // 2️⃣ درخواست assignment ها
      final response = await _dioClient.get(
        '/items/form_assignments',
        queryParameters: {
          // اگر child_id در DB عدد ساده است:
          'filter[child_id][_eq]': numericChildId,
          'fields': '*,template_id.*',
        },
      );

      final data = response.data['data'] as List;
      print('🔹 Form assignments raw data: $data');

      if (data.isEmpty) {
        print('⚠️ No form assignments found for this child.');
        return [];
      }

      // 3️⃣ Map کردن هر assignment به مدل
      List<FormAssignmentModel> assignments = data.map((assignmentJson) {
        // template_id ممکن است null یا یک لیست باشد
        Map<String, dynamic> templateJson = {};
        if (assignmentJson['template_id'] != null) {
          if (assignmentJson['template_id'] is List &&
              assignmentJson['template_id'].isNotEmpty) {
            templateJson = assignmentJson['template_id'][0];
          } else if (assignmentJson['template_id'] is Map<String, dynamic>) {
            templateJson = assignmentJson['template_id'];
          }
        }
        templateJson ??= {'name': 'بدون عنوان', 'description': ''};

        return FormAssignmentModel.fromJson(assignmentJson, templateJson);
      }).toList();

      // 4️⃣ مرتب‌سازی بر اساس status و dueAt
      final statusOrder = ['pending', 'incomplete', 'not_started', 'completed'];
      assignments.sort((a, b) {
        final statusCompare =
        statusOrder.indexOf(a.status).compareTo(statusOrder.indexOf(b.status));
        if (statusCompare != 0) return statusCompare;
        if (a.dueAt == null && b.dueAt == null) return 0;
        if (a.dueAt == null) return 1;
        if (b.dueAt == null) return -1;
        return b.dueAt!.compareTo(a.dueAt!); // DESC
      });

      print('✅ Total assignments mapped: ${assignments.length}');
      return assignments;
    } catch (e) {
      print('❌ Error fetching form assignments: $e');
      return [];
    }
  }
}
