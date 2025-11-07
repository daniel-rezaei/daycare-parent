// domain/repository/guardian_banking_repository.dart
import '../entities/guardian_banking_entity.dart';

abstract class GuardianBankingRepository {
  Future<GuardianBankingEntity?> fetchByGuardianId(String guardianId);
  Future<void> updateConsent(String bankingRecordId, bool consent);
  Future<void> updateBankInfo(String bankingRecordId, {
    String? accountNumber,
    String? transitNumber,
    String? institutionNumber,
  });
}
