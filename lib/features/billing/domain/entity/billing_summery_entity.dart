
class BillingSummaryEntity {
  final String currentBalanceMinor;
  final String pendingMinor;
  final String currencyIso;
  final String guardianId;

  BillingSummaryEntity({
    required this.currentBalanceMinor,
    required this.pendingMinor,
    required this.currencyIso,
    required this.guardianId,
  });
}
