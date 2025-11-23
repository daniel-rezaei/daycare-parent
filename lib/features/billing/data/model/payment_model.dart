


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
    int billingAccountId = 0;
    final ba = json['billing_account_id'];
    if (ba is int) {
      billingAccountId = ba;
    }

    return PaymentModel(
      id: json['id']?.toString() ?? '',
      billingAccountId: billingAccountId,
      meta: json['meta']?.toString(),
      paymentMethod: json['Payment_Method']?.toString(),
      currencyIso: json['currency_iso']?.toString() ?? 'USD',
      provider: json['provider']?.toString(),
      status: json['status']?.toString() ?? 'unknown',
      paymentDate: json['Payment_Date'] != null
          ? DateTime.tryParse(json['Payment_Date']) ?? DateTime.now()
          : DateTime.now(),
      amountMinor: json['amount_minor'] != null
          ? double.tryParse(json['amount_minor'].toString()) ?? 0
          : 0,
      invoiceIds: (json['invoice_id'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}

