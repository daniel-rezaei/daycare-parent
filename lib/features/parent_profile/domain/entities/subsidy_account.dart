class SubsidyAccount {
  final String id;
  final String childId;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? amount;

  SubsidyAccount({
    required this.id,
    required this.childId,
    required this.status,
    this.startDate,
    this.endDate,
    this.amount,
  });

  bool get isActive {
    final now = DateTime.now();
    if (status.toLowerCase().trim() != 'active') return false;
    if (startDate != null && startDate!.isAfter(now)) return false;
    if (endDate != null && endDate!.isBefore(now)) return false;
    return true;
  }
}
