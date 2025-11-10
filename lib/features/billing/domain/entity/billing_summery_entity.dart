
class BillingSummaryEntity {
  final int currentBalanceMinor;
  final int pendingMinor;
  final String currencyIso;
  final String guardianId;

  BillingSummaryEntity({
    required this.currentBalanceMinor,
    required this.pendingMinor,
    required this.currencyIso,
    required this.guardianId,
  });
}
