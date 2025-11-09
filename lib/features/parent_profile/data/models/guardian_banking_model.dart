import '../../domain/entities/guardian_banking.dart';

class GuardianBankingModel extends GuardianBanking {
  GuardianBankingModel({
    required String id,
    required String guardianId,
    required bool consent,
    DateTime? consentAt,
    String? accountHolderName,
    String? accountType,
    String? institutionNumber,
    String? transitNumber,
    String? accountLast4,
  }) : super(
    id: id,
    guardianId: guardianId,
    consent: consent,
    consentAt: consentAt,
    accountHolderName: accountHolderName,
    accountType: accountType,
    institutionNumber: institutionNumber,
    transitNumber: transitNumber,
    accountLast4: accountLast4,
  );

  factory GuardianBankingModel.fromJson(Map<String, dynamic> json) {
    return GuardianBankingModel(
      id: json['id'] as String,
      guardianId: json['guardian_id'] as String? ?? '',
      consent: (json['consent'] == true),
      consentAt: json['consent_at_'] != null ? DateTime.parse(json['consent_at_']) : null,
      accountHolderName: json['account_holder_name'] as String?,
      accountType: json['account_type'] as String?,
      institutionNumber: json['institution_number'] as String?,
      transitNumber: json['transit_number'] as String?,
      accountLast4: json['account_last4_'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guardian_id': guardianId,
      'consent': consent,
      'consent_at_': consentAt?.toIso8601String(),
      'account_holder_name': accountHolderName,
      'account_type': accountType,
      'institution_number': institutionNumber,
      'transit_number': transitNumber,
      'account_last4_': accountLast4,
    };
  }
}
