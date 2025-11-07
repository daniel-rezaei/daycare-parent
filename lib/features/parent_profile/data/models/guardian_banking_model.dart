// data/models/guardian_banking_model.dart
import '../../domain/entities/guardian_banking_entity.dart';

class GuardianBankingModel extends GuardianBankingEntity {
  GuardianBankingModel({
    required super.id,
    required super.consent,
    super.guardianId,
    super.consentAt,
    super.accountNumber,
    super.transitNumber,
    super.institutionNumber,
    super.accountHolderName,
    super.bankName,
  });

  factory GuardianBankingModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? s) {
      if (s == null) return null;
      try {
        return DateTime.parse(s);
      } catch (_) {
        return null;
      }
    }

    return GuardianBankingModel(
      id: json['id'] ?? '',
      guardianId: json['guardian_id'],
      consent: json['consent'] == true,
      consentAt: parseDate(json['consent_at_']),
      accountNumber: json['account_number'],
      transitNumber: json['transit_number'],
      institutionNumber: json['institution_number'],
      accountHolderName: json['account_holder_name'],
      bankName: json['bank_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'guardian_id': guardianId,
    'consent': consent,
    'consent_at_': consentAt?.toIso8601String(),
    'account_number': accountNumber,
    'transit_number': transitNumber,
    'institution_number': institutionNumber,
    'account_holder_name': accountHolderName,
    'bank_name': bankName,
  };
}
