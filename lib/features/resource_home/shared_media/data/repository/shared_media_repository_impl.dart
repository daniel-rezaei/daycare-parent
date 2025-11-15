import '../../../../../core/network/dio_client.dart';
import '../../domain/entity/shared_media_entity.dart';
import '../../domain/repository/shared_media_repository.dart';
import '../model/shared_media_model.dart';

class SharedMediaRepositoryImpl implements SharedMediaRepository {
  final DioClient _dioClient;

  SharedMediaRepositoryImpl(this._dioClient);

  @override
  Future<List<SharedMediaEntity>> getSharedMedia({required String childId}) async {
    try {
      print('🔹 [SharedMediaRepo] Fetching shared media for childId(uuid): $childId');

      final response = await _dioClient.get(
        '/items/shared_media',
        queryParameters: {
          'filter[shared_to_guardians][_eq]': 'true',
          'fields': '*.*',
        },
      );

      print('🟢 [SharedMediaRepo] Raw response: ${response.data}');

      final data = response.data['data'] as List;

      print('📦 [SharedMediaRepo] Received ${data.length} total items from server');

      final filtered = data.where((json) {
        final childLinks = json['child_link'] as List?;
        if (childLinks == null) return false;

        final childIds = childLinks
            .map((e) => e['Child_id'])
            .where((v) => v != null)
            .toList();

        final matches = childIds.contains(childId);

        print('🔍 Child_ids in item: $childIds | lookingFor: $childId | match=$matches');
        return matches;
      }).toList();

      print('🎯 [SharedMediaRepo] Filtered items: ${filtered.length}');

      return filtered.map((json) => SharedMediaModel.fromJson(json)).toList();
    } catch (e, stack) {
      print('❌ [SharedMediaRepo] Error: $e');
      print(stack);
      return [];
    }
  }
}
