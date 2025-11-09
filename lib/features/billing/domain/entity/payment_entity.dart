
class PaymentEntity {
  final String id;
  final int billingAccountId;
  final String? meta;
  final String? paymentMethod;
  final String currencyIso;
  final String? provider;
  final String status;
  final DateTime paymentDate;
  final double amountMinor;
  final List<String>? invoiceIds;

  PaymentEntity({
    required this.id,
    required this.billingAccountId,
    this.meta,
    this.paymentMethod,
    required this.currencyIso,
    this.provider,
    required this.status,
    required this.paymentDate,
    required this.amountMinor,
    this.invoiceIds,
  });
}
