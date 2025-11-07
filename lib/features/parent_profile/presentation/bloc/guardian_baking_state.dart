import '../../domain/entities/guardian_banking_entity.dart';

abstract class GuardianBankingState {}

class GuardianBankingInitial extends GuardianBankingState {}

class GuardianBankingLoading extends GuardianBankingState {}

class GuardianBankingLoaded extends GuardianBankingState {
  final GuardianBankingEntity data;
  GuardianBankingLoaded(this.data);
}

class GuardianBankingError extends GuardianBankingState {
  final String message;
  GuardianBankingError(this.message);
}

class GuardianBankingUpdated extends GuardianBankingState {
  final bool success;
  GuardianBankingUpdated(this.success);
}
