
// domain/entities/billing_document_entity.dart
class BillingDocumentEntity {
  final String id;
  final String documentId;
  final int? billingAccountId;
  final String docKind;
  final String? currencyIso;
  final DateTime? periodStart;
  final DateTime? periodEnd;
  final String? notes;

  BillingDocumentEntity({
    required this.id,
    required this.documentId,
    this.billingAccountId,
    required this.docKind,
    this.currencyIso,
    this.periodStart,
    this.periodEnd,
    this.notes,
  });
}
