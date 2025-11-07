// domain/entities/subsidy_account_entity.dart
class SubsidyAccountEntity {
  final String id;
  final String status;
  final String? providerName;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? childId;
  final String? guardianId;

  SubsidyAccountEntity({
    required this.id,
    required this.status,
    this.providerName,
    this.startDate,
    this.endDate,
    this.childId,
    this.guardianId,
  });

  bool get isActive {
    final now = DateTime.now();
    if (status.toLowerCase() != 'active') return false;
    if (startDate != null && startDate!.isAfter(now)) return false;
    if (endDate != null && endDate!.isBefore(now)) return false;
    return true;
  }
}
