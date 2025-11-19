import 'package:parent_app/core/network/dio_client.dart';
import 'package:parent_app/features/home_page/domain/repositories/child_repository.dart';
import '../../../../core/utils/local_storage.dart';
import '../../domain/entities/child_entity.dart';
import '../model/child_model.dart';

class ChildRepositoryImpl implements ChildRepository {
  final DioClient dio;

  ChildRepositoryImpl(this.dio);

  @override
  Future<List<ChildEntity>> getChildrenData() async {
    try {
      // --- 1. دریافت همه بچه‌ها ---
      final response = await dio.get('/items/Child', queryParameters: {
        'fields': '''
          *,
          contact_id,
          contact_id.*,
          contact_id.Contacts_id.*,
          primary_room_id,
          primary_room_id.*,
          primary_room_id.Class_id.*,
          guardians
        ''',
      });

      final data = response.data['data'] as List;
      if (data.isEmpty) return [];

      // --- 2. دریافت والد لاگین شده ---
      final user = await LocalStorage.getUser();
      if (user == null) return [];

      final parentContactId = user.contactId; // ⚠ اینجا اصلاح شد
      print("Parent ContactId = $parentContactId");

      // --- 3. دریافت Guardian ها از سرور ---
      final guardianResponse = await dio.get('/items/Guardian', queryParameters: {
        'filter[contact_id][_eq]': parentContactId,
        'fields': 'Child',
      });

      final guardianData = guardianResponse.data['data'] as List;

      // --- 4. گرفتن لیست Child numbers (که Guardian داده) ---
      final childNumbers = guardianData
          .expand((g) => g['Child'] as List)
          .map((e) => e.toString())
          .toList();

      print("Child numbers for parent: $childNumbers");

      // --- 5. فیلتر کردن بچه‌ها ---
      final children = data.map((json) => ChildModel.fromJson(json)).where((child) {
        // در ChildModel، guardians عدد هستند
        return child.guardians.any((g) => childNumbers.contains(g));
      }).toList();

      print("Parent ContactId = $parentContactId, children found = ${children.length}");
      print("✅ ${children.length} children found for parent $parentContactId");

      return children;
    } catch (e) {
      print('Error fetching children: $e');
      return [];
    }
  }
}
