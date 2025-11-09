
import '../entities/guardian_banking.dart';
import 'get_guardian_banking.dart';
import 'get_subsidy_toggle.dart';

class GuardianDashboard {
  final GetGuardianBanking getBanking;
  final GetSubsidyToggle getSubsidyToggle;

  GuardianDashboard(this.getBanking, this.getSubsidyToggle);

  Future<GuardianDashboardResult> call({required String contactId, String? guardianId}) async {
    final banking = await getBanking.call(guardianId: guardianId, contactId: contactId);
    final subsidyOn = await getSubsidyToggle.call(contactId);
    return GuardianDashboardResult(banking: banking, subsidyToggleOn: subsidyOn);
  }
}

class GuardianDashboardResult {
  final GuardianBanking? banking;
  final bool subsidyToggleOn;
  GuardianDashboardResult({required this.banking, required this.subsidyToggleOn});
}
