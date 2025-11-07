

import '../../domain/entity/billing_summery_entity.dart';

class BillingSummaryModel extends BillingSummaryEntity {
  BillingSummaryModel({
    required super.currentBalanceMinor,
    required super.pendingMinor,
    required super.currencyIso,
  });

  factory BillingSummaryModel.fromJson(Map<String, dynamic> json) {
    return BillingSummaryModel(
      currentBalanceMinor: json['current_balance_minor'] ?? 0,
      pendingMinor: json['pending_minor'] ?? 0,
      currencyIso: json['currency_iso'] ?? '',
    );
  }
}
