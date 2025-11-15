import '../../../../../core/network/dio_client.dart';
import '../../domain/entity/document_entity.dart';
import '../../domain/repository/document_repository.dart';
import '../model/document_model.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DioClient _dioClient;

  DocumentRepositoryImpl(this._dioClient);

  @override
  Future<List<DocumentEntity>> getDocuments({
    String? parentId,
  }) async {
    try {

      final query = {
        'filter[deleted_at][_null]': true,
        'fields': '*,file.*',
        'sort': '-effective_date,-created_at',
        'filter[_or][0][visibility_scope][_eq]': 'public',
        'filter[_or][1][_and][0][visibility_scope][_eq]': 'parent_only',

      };

      final response = await _dioClient.get(
        '/items/Documents',
        queryParameters: query,
      );

      final data = response.data['data'] as List;
      return data.map((e) => DocumentModel.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error fetching documents: $e');
      rethrow;
    }
  }
}
