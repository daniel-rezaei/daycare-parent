import '../../domain/entity/billing_doc_entity.dart';

class BillingDocumentModel extends BillingDocumentEntity {
  BillingDocumentModel({
    required String id,
    required String documentId,
    int? billingAccountId,
    required String docKind,
    String? currencyIso,
    DateTime? periodStart,
    DateTime? periodEnd,
    String? notes,
  }) : super(
    id: id,
    documentId: documentId,
    billingAccountId: billingAccountId,
    docKind: docKind,
    currencyIso: currencyIso,
    periodStart: periodStart,
    periodEnd: periodEnd,
    notes: notes,
  );

  factory BillingDocumentModel.fromJson(Map<String, dynamic> json) {
    return BillingDocumentModel(
      id: json['id'] ?? '',
      documentId: json['document_id'] ?? '',
      billingAccountId: json['billing_account_id'],
      docKind: json['doc_kind'] ?? '',
      currencyIso: json['currency_iso'],
      periodStart: json['period_start'] != null
          ? DateTime.parse(json['period_start'])
          : null,
      periodEnd: json['period_end'] != null
          ? DateTime.parse(json['period_end'])
          : null,
      notes: json['notes'],
    );
  }
}
