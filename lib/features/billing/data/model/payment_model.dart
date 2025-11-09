


import '../../domain/entity/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  PaymentModel({
    required super.id,
    required super.billingAccountId,
    super.meta,
    super.paymentMethod,
    required super.currencyIso,
    super.provider,
    required super.status,
    required super.paymentDate,
    required super.amountMinor,
    super.invoiceIds,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      billingAccountId: json['billing_account_id'],
      meta: json['meta'],
      paymentMethod: json['Payment_Method'],
      currencyIso: json['currency_iso'],
      provider: json['provider'],
      status: json['status'],
      paymentDate: DateTime.parse(json['Payment_Date']),
      amountMinor: double.parse(json['amount_minor']),
      invoiceIds: (json['invoice_id'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}
