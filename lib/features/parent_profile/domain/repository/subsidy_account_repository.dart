// domain/repository/subsidy_repository.dart
import '../entities/subsidy_account_entity.dart';

abstract class SubsidyRepository {
  Future<List<SubsidyAccountEntity>> fetchForGuardianOrContact(String contactId);
  Future<bool> hasActiveSubsidy(String contactId);
}
