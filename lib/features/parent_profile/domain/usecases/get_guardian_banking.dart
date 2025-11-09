import '../repository/guardian_repository.dart';
import '../entities/guardian_banking.dart';

class GetGuardianBanking {
  final GuardianRepository repo;
  GetGuardianBanking(this.repo);

  Future<GuardianBanking?> call({String? guardianId, String? contactId}) async {
    if (guardianId != null) {
      return await repo.getGuardianBankingByGuardianId(guardianId);
    }
    if (contactId != null) {
      return await repo.getGuardianBankingByContactId(contactId);
    }
    return null;
  }
}
