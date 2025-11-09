abstract class GuardianDashboardEvent {}

class LoadGuardianDashboard extends GuardianDashboardEvent {
  final String contactId;
  final String? guardianId;


  LoadGuardianDashboard({
    required this.contactId,
    this.guardianId,

  });
}

// Event برای تغییر toggle
class UpdateConsent extends GuardianDashboardEvent {
  final bool consentValue;
  final String guardianId;
  final String fullName; // fallback safe

  UpdateConsent({
    required this.consentValue,
    required this.guardianId,
    required this.fullName,
  });
}
