import '../repository/billing_doc_repository.dart';

class GetTaxStatementYears {
  final BillingDocRepository repository;
  GetTaxStatementYears(this.repository);

  Future<List<int>> call(String guardianId) {
    return repository.getTaxStatementYears(guardianId);
  }
}
