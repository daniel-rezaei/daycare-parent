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
    // اگر billing_account_id null یا لیست خالی بود، صفر میزاریم
    int billingAccountId = 0;
    final ba = json['billing_account_id'];
    if (ba is int) {
      billingAccountId = ba;
    } else if (ba is List && ba.isNotEmpty && ba[0] is int) {
      billingAccountId = ba[0];
    }

    return InvoiceModel(
      id: json['id']?.toString() ?? '',
      billingAccountId: billingAccountId,
      meta: json['meta']?.toString(),
      currencyIso: json['currency_iso']?.toString() ?? 'USD',
      invoiceNumber: json['invoice_number']?.toString() ?? '',
      status: json['status']?.toString() ?? 'unknown',
      dueDate: json['due_date'] != null
          ? DateTime.tryParse(json['due_date']) ?? DateTime.now()
          : DateTime.now(),
      issueDate: json['issue_date'] != null
          ? DateTime.tryParse(json['issue_date']) ?? DateTime.now()
          : DateTime.now(),
      balanceMinor: json['balance_minor'] != null
          ? double.tryParse(json['balance_minor'].toString()) ?? 0
          : 0,
      totalMinor: json['total_minor'] != null
          ? double.tryParse(json['total_minor'].toString()) ?? 0
          : 0,
      pdfDocumentId: json['pdf_document_id']?.toString(),
    );
  }
}

