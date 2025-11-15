
import '../entity/document_entity.dart';

abstract class DocumentRepository {
  Future<List<DocumentEntity>> getDocuments();
}
