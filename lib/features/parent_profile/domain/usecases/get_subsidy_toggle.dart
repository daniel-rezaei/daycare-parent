

import '../../domain/repository/guardian_repository.dart';
class GetSubsidyToggle {
  final GuardianRepository repo;
  GetSubsidyToggle(this.repo);

  /// Returns true if any child associated with contactId has an active subsidy AND the contact is primary payer
  Future<bool> call(String contactId) async {
    final cgs = await repo.getChildGuardiansByContactId(contactId);
    for (final cg in cgs) {
      if (cg.isPrimaryPayer == true) {
        final subsidies = await repo.getSubsidyAccountsByChildId(cg.childId);
        if (subsidies.any((s) => s.isActive)) return true;
      }
    }
    return false;
  }
}
