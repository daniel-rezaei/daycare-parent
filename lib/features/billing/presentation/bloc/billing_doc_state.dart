
import '../../domain/entity/billing_doc_entity.dart';

abstract class BillingDocState {}

class BillingDocInitial extends BillingDocState {}

class BillingDocLoading extends BillingDocState {}

class BillingDocError extends BillingDocState {
  final String message;
  BillingDocError(this.message);
}

class LatestStatementLoaded extends BillingDocState {
  final BillingDocumentEntity? document;
  LatestStatementLoaded(this.document);
}

class TaxYearsLoaded extends BillingDocState {
  final List<int> years;
  TaxYearsLoaded(this.years);
}

class TaxStatementLoaded extends BillingDocState {
  final BillingDocumentEntity? document;
  TaxStatementLoaded(this.document);
}