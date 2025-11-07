abstract class GuardianBankingEvent {}

class LoadGuardianBankingEvent extends GuardianBankingEvent {
  final String guardianId;
  LoadGuardianBankingEvent(this.guardianId);
}

class ToggleConsentEvent extends GuardianBankingEvent {
  final String recordId;
  final bool consent;
  ToggleConsentEvent(this.recordId, this.consent);
}

class UpdateBankFieldsEvent extends GuardianBankingEvent {
  final String recordId;
  final String? accountNumber;
  final String? transitNumber;
  final String? institutionNumber;

  UpdateBankFieldsEvent({
    required this.recordId,
    this.accountNumber,
    this.transitNumber,
    this.institutionNumber,
  });
}
