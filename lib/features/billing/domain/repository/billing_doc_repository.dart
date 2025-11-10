


import '../entity/billing_doc_entity.dart';

abstract class BillingDocRepository {
  Future<BillingDocumentEntity?> getLatestStatement(String guardianId);
  Future<List<int>> getTaxStatementYears(String guardianId);
  Future<BillingDocumentEntity?> getTaxStatementByYear(String guardianId, int year);
}
