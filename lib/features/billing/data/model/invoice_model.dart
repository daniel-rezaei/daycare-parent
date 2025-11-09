

import '../../domain/entity/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  InvoiceModel({
    required super.id,
    required super.billingAccountId,
    super.meta,
    required super.currencyIso,
    required super.invoiceNumber,
    required super.status,
    required super.dueDate,
    required super.issueDate,
    required super.balanceMinor,
    required super.totalMinor,
    super.pdfDocumentId,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      billingAccountId: json['billing_account_id'],
      meta: json['meta'],
      currencyIso: json['currency_iso'],
      invoiceNumber: json['invoice_number'],
      status: json['status'],
      dueDate: DateTime.parse(json['due_date']),
      issueDate: DateTime.parse(json['issue_date']),
      balanceMinor: double.parse(json['balance_minor']),
      totalMinor: double.parse(json['total_minor']),
      pdfDocumentId: json['pdf_document_id'],
    );
  }
}
