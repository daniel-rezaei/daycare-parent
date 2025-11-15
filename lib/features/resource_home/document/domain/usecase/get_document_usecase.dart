
import '../entity/document_entity.dart';
import '../repository/document_repository.dart';

class GetDocumentsUseCase {
  final DocumentRepository repository;

  GetDocumentsUseCase(this.repository);

  Future<List<DocumentEntity>> call() {
    return repository.getDocuments();
  }
}
