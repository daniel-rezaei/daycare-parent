// guardian_repository_impl.dart
import '../../domain/entity/guardian_entity.dart';
import '../../domain/repository/guardian_repository.dart';
import '../model/guardian_model.dart';
import '../../../../core/network/dio_client.dart';

class GuardianRepositoryImpl implements GuardianRepository {
  final DioClient dioClient;

  GuardianRepositoryImpl(this.dioClient);

  @override
  Future<List<GuardianEntity>> getPrimaryGuardiansForChild({required String childId, int limit = 2}) async {
    // دریافت Guardian JSON
    final guardiansResponse = await dioClient.get('/items/Child_Guardian', queryParameters: {
      'filter[child_id]': childId,
    });
    print('🟢 Guardians API Response: ${guardiansResponse.data}');
    final guardiansData = (guardiansResponse.data['data'] as List).cast<Map<String, dynamic>>();

    // دریافت Contact JSON برای contact_ids
    final contactIds = guardiansData.map((g) => g['contact_id'] as String).toList();
    final contactsResponse = await dioClient.get('/items/Contacts', queryParameters: {
      'filter[id][_in]': contactIds.join(','),
    });
    print('🟢 Contacts API Response: ${contactsResponse.data}');
    final contactsData = (contactsResponse.data['data'] as List).cast<Map<String, dynamic>>();

    // Map contact_id -> Contact JSON
    final contactMap = {for (var c in contactsData) c['id'] ?? c['contact_id']: c};

    // Merge Guardian + Contact
    final merged = guardiansData.map((g) {
      final contactJson = contactMap[g['contact_id']];
      final guardian = GuardianModel.fromJson(g, contactJson);
      print('Guardian ${guardian.firstName} ${guardian.lastName} photo UUID: ${guardian.photo}');
      return guardian; // <-- فقط همون شیء ساخته شده را برگردون
    }).toList();


    // مرتب سازی شبیه SQL
    merged.sort((a, b) {
      if (a.isPrimary != b.isPrimary) return b.isPrimary ? 1 : -1;

      final aParent = (a.relation.toLowerCase() == 'mother' || a.relation.toLowerCase() == 'father') ? 1 : 0;
      final bParent = (b.relation.toLowerCase() == 'mother' || b.relation.toLowerCase() == 'father') ? 1 : 0;
      if (aParent != bParent) return bParent - aParent;

      return a.fullName.compareTo(b.fullName);
    });
    print('Merged Guardians: $merged');
    return merged.take(limit).toList();
  }
}
