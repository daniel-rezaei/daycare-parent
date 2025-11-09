import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository/guardian_repository.dart';
import '../../domain/entities/guardian_banking.dart';
import '../../domain/usecases/get_guardian_banking.dart';
import '../../domain/usecases/get_subsidy_toggle.dart';
import 'guardian_banking_event.dart';
import 'guardian_banking_state.dart';

class GuardianDashboardBloc extends Bloc<GuardianDashboardEvent, GuardianDashboardState> {
  final GetGuardianBanking getBanking;
  final GetSubsidyToggle getSubsidyToggle;
  final GuardianRepository repo;

  GuardianDashboardBloc({
    required this.getBanking,
    required this.getSubsidyToggle,
    required this.repo,
  }) : super(GuardianDashboardInitial()) {

    on<LoadGuardianDashboard>(_onLoadDashboard);
    on<UpdateConsent>(_onUpdateConsent);
  }

  Future<void> _onLoadDashboard(
      LoadGuardianDashboard event,
      Emitter<GuardianDashboardState> emit,
      ) async {
    emit(GuardianDashboardLoading());
    try {
      final banking = await getBanking.call(
        guardianId: event.guardianId,
        contactId: event.contactId,

      );
      final subsidyToggleOn = await getSubsidyToggle.call(event.contactId);

      emit(GuardianDashboardLoaded(
        banking: banking,
        subsidyToggleOn: subsidyToggleOn,
      ));
    } catch (e) {
      emit(GuardianDashboardError(e.toString()));
    }
  }

  Future<void> _onUpdateConsent(
      UpdateConsent event,
      Emitter<GuardianDashboardState> emit,
      ) async {
    final currentState = state;
    if (currentState is GuardianDashboardLoaded) {
      final banking = currentState.banking;

      if (banking == null) {
        emit(GuardianDashboardError(
            "You do not have permission to update banking information."));
        return;
      }

      try {
        await repo.updateGuardianConsent(
          guardianId: event.guardianId,
          consent: event.consentValue,

        );

        final updatedBanking = banking.copyWith(
          consent: event.consentValue,
          consentAt: DateTime.now(),
        );

        emit(GuardianDashboardLoaded(
          banking: updatedBanking,
          subsidyToggleOn: currentState.subsidyToggleOn,
        ));
      } catch (e) {
        emit(GuardianDashboardError("Failed to update consent: $e"));
      }
    }
  }
}


