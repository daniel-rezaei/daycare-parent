// domain/usecases/get_guardian_banking_usecase.dart
import '../entities/guardian_banking_entity.dart';
import '../repository/guardian_banking_repository.dart';

class GetGuardianBankingUseCase {
  final GuardianBankingRepository repository;
  GetGuardianBankingUseCase(this.repository);

  Future<GuardianBankingEntity?> call(String guardianId) {
    return repository.fetchByGuardianId(guardianId);
  }
}
