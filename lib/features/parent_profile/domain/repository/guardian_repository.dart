
import '../entities/guardian_banking.dart';
import '../entities/subsidy_account.dart';
import '../entities/child_guardian.dart';

abstract class GuardianRepository {
  /// Get ChildGuardian rows for a contact_id (may be multiple children)
  Future<List<ChildGuardian>> getChildGuardiansByContactId(String contactId);

  /// Get subsidy accounts by child_id
  Future<List<SubsidyAccount>> getSubsidyAccountsByChildId(String childId);

  /// Get guardian banking by guardian_id (primary) or fallback
  Future<GuardianBanking?> getGuardianBankingByGuardianId(String guardianId);

  /// Convenience: try to fetch guardian banking by contactId (if guardian_id not present)
  Future<GuardianBanking?> getGuardianBankingByContactId(String contactId);

  Future<void> updateGuardianConsent({
    required String guardianId,
    required bool consent,
  });

  // اضافه کردن fullName برای fallback امن



}
