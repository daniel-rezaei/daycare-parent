
class GuardianBanking {
  final String id;
  final String guardianId;
  final bool consent;
  final DateTime? consentAt;
  final String? accountHolderName;
  final String? accountType;
  final String? institutionNumber;
  final String? transitNumber;
  final String? accountLast4;
  // store encrypted off-app; app should never show unmasked except via secure flows
  GuardianBanking({
    required this.id,
    required this.guardianId,
    required this.consent,
    this.consentAt,
    this.accountHolderName,
    this.accountType,
    this.institutionNumber,
    this.transitNumber,
    this.accountLast4,
  });
  GuardianBanking copyWith({
    String? id,
    String? guardianId,
    bool? consent,
    DateTime? consentAt,
    String? accountHolderName,
    String? accountType,
    String? institutionNumber,
    String? transitNumber,
    String? accountLast4,
  }) {
    return GuardianBanking(
      id: id ?? this.id,
      guardianId: guardianId ?? this.guardianId,
      consent: consent ?? this.consent,
      consentAt: consentAt ?? this.consentAt,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountType: accountType ?? this.accountType,
      institutionNumber: institutionNumber ?? this.institutionNumber,
      transitNumber: transitNumber ?? this.transitNumber,
      accountLast4: accountLast4 ?? this.accountLast4,
    );
  }
}
