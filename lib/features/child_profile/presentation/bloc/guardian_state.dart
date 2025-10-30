import '../../domain/entity/guardian_entity.dart';

abstract class GuardianState {}
class GuardianInitial extends GuardianState {}
class GuardianLoading extends GuardianState {}
class GuardianLoaded extends GuardianState {
  final List<GuardianEntity> guardians;
  GuardianLoaded(this.guardians);
}
class GuardianEmpty extends GuardianState {}
class GuardianError extends GuardianState {
  final String message;
  GuardianError(this.message);
}
