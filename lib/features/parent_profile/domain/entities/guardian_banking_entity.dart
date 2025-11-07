// domain/entities/guardian_banking_entity.dart
class GuardianBankingEntity {
  final String id;
  final String? guardianId;
  final bool consent;
  final DateTime? consentAt;
  final String? accountNumber;
  final String? transitNumber;
  final String? institutionNumber;
  final String? accountHolderName;
  final String? bankName;

  GuardianBankingEntity({
    required this.id,
    this.guardianId,
    required this.consent,
    this.consentAt,
    this.accountNumber,
    this.transitNumber,
    this.institutionNumber,
    this.accountHolderName,
    this.bankName,
  });
}
