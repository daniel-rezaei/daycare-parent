// domain/usecases/update_guardian_consent_usecase.dart
import '../repository/guardian_banking_repository.dart';

class UpdateGuardianConsentUseCase {
  final GuardianBankingRepository repository;
  UpdateGuardianConsentUseCase(this.repository);

  Future<void> call(String bankingId, bool consent) {
    return repository.updateConsent(bankingId, consent);
  }
}
