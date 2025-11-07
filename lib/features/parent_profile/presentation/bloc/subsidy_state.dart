
import '../../domain/entities/subsidy_account_entity.dart';

abstract class SubsidyState {}

class SubsidyInitial extends SubsidyState {}

class SubsidyLoading extends SubsidyState {}

class SubsidyLoaded extends SubsidyState {
  final List<SubsidyAccountEntity> subsidies;
  final bool hasActive;
  SubsidyLoaded({required this.subsidies, required this.hasActive});
}

class SubsidyError extends SubsidyState {
  final String message;
  SubsidyError(this.message);
}
