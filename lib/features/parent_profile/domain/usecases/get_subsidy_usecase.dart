// domain/usecases/get_subsidy_usecase.dart
import '../entities/subsidy_account_entity.dart';
import '../repository/subsidy_account_repository.dart';


class GetSubsidyUseCase {
  final SubsidyRepository repository;
  GetSubsidyUseCase(this.repository);

  Future<List<SubsidyAccountEntity>> call(String contactId) {
    return repository.fetchForGuardianOrContact(contactId);
  }

  Future<bool> hasActive(String contactId) {
    return repository.hasActiveSubsidy(contactId);
  }
}
