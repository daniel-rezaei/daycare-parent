import '../entity/billing_doc_entity.dart';
import '../repository/billing_doc_repository.dart';

class GetTaxStatementByYear {
  final BillingDocRepository repository;
  GetTaxStatementByYear(this.repository);

  Future<BillingDocumentEntity?> call(String guardianId, int year) {
    return repository.getTaxStatementByYear(guardianId, year);
  }
}
