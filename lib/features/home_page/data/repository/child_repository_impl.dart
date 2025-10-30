
import 'package:parent_app/core/network/dio_client.dart';
import 'package:parent_app/features/home_page/domain/repositories/child_repository.dart';
import '../../domain/entities/child_entity.dart';
import '../model/child_model.dart';


class ChildRepositoryImpl implements ChildRepository {
  final DioClient dio;

  ChildRepositoryImpl(this.dio);

  @override
  Future<ChildEntity?> getChildData() async {
    try {
      print('📡 Fetching child data with expanded relations...');

      final response = await dio.get(
        '/items/Child',
        queryParameters: {
          'fields': '''
      *,
      contact_id,
      contact_id.*,
      contact_id.Contacts_id.*,
      primary_room_id,
      primary_room_id.*,
      primary_room_id.Class_id.*
    ''',
        },
      );


      final data = response.data['data'] as List;
      if (data.isEmpty) return null;

      final child = data.first;
      final childModel = ChildModel.fromJson(child);

      print('✅ ChildModel created successfully: ${childModel.id}');
      return childModel;
    } catch (e) {
      print('❌ Error fetching child data: $e');
      return null;
    }
  }
}

