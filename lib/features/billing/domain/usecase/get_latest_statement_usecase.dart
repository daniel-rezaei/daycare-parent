
import '../entity/billing_doc_entity.dart';
import '../repository/billing_doc_repository.dart';

class GetLatestStatement {
  final BillingDocRepository repository;
  GetLatestStatement(this.repository);

  Future<BillingDocumentEntity?> call(String guardianId) {
    return repository.getLatestStatement(guardianId);
  }
}