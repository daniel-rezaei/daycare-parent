
class InvoiceEntity {
  final String id;
  final int billingAccountId;
  final String? meta;
  final String currencyIso;
  final String invoiceNumber;
  final String status;
  final DateTime dueDate;
  final DateTime issueDate;
  final double balanceMinor;
  final double totalMinor;
  final String? pdfDocumentId;

  InvoiceEntity({
    required this.id,
    required this.billingAccountId,
    this.meta,
    required this.currencyIso,
    required this.invoiceNumber,
    required this.status,
    required this.dueDate,
    required this.issueDate,
    required this.balanceMinor,
    required this.totalMinor,
    this.pdfDocumentId,
  });
}
