
class BillingSummaryEntity {
  final int currentBalanceMinor;
  final int pendingMinor;
  final String currencyIso;

  BillingSummaryEntity({
    required this.currentBalanceMinor,
    required this.pendingMinor,
    required this.currencyIso,
  });
}
