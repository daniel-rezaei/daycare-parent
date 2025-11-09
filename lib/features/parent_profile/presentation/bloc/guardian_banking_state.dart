import '../../domain/entities/guardian_banking.dart';

/// States
abstract class GuardianDashboardState {}

class GuardianDashboardInitial extends GuardianDashboardState {}

class GuardianDashboardLoading extends GuardianDashboardState {}

class GuardianDashboardLoaded extends GuardianDashboardState {
  final GuardianBanking? banking;
  final bool subsidyToggleOn;

  GuardianDashboardLoaded({required this.banking, required this.subsidyToggleOn});
}

class GuardianDashboardError extends GuardianDashboardState {
  final String message;

  GuardianDashboardError(this.message);
}
