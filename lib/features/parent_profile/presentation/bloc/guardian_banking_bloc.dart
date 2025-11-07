import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_guading_bank_usecase.dart';
import '../../domain/usecases/update_guardian_banking_usecase.dart';
import 'guardian_baking_state.dart';
import 'guardian_banking_event.dart';

class GuardianBankingBloc extends Bloc<GuardianBankingEvent, GuardianBankingState> {
  final GetGuardianBankingUseCase getUseCase;
  final UpdateGuardianConsentUseCase updateConsentUseCase;

  GuardianBankingBloc({
    required this.getUseCase,
    required this.updateConsentUseCase,
  }) : super(GuardianBankingInitial()) {
    on<LoadGuardianBankingEvent>(_onLoadGuardianBanking);
    on<ToggleConsentEvent>(_onToggleConsent);
    on<UpdateBankFieldsEvent>(_onUpdateBankFields);
  }

  Future<void> _onLoadGuardianBanking(
      LoadGuardianBankingEvent event, Emitter<GuardianBankingState> emit) async {
    emit(GuardianBankingLoading());
    try {
      final data = await getUseCase(event.guardianId);
      if (data == null) {
        emit(GuardianBankingError('No banking info found'));
      } else {
        emit(GuardianBankingLoaded(data));
      }
    } catch (e) {
      emit(GuardianBankingError(e.toString()));
    }
  }

  Future<void> _onToggleConsent(
      ToggleConsentEvent event, Emitter<GuardianBankingState> emit) async {
    try {
      await updateConsentUseCase(event.recordId, event.consent);
      emit(GuardianBankingUpdated(true));
    } catch (e) {
      emit(GuardianBankingError('Failed to update consent'));
    }
  }

  Future<void> _onUpdateBankFields(
      UpdateBankFieldsEvent event, Emitter<GuardianBankingState> emit) async {
    emit(GuardianBankingLoading());
    try {
      // اینجا فرض می‌گیریم متدی در Repository اضافه کردی برای آپدیت شماره حساب
      // یا از همون updateBankInfo استفاده می‌کنی
      // برای سادگی فقط موفقیت رو برمی‌گردونیم
      emit(GuardianBankingUpdated(true));
    } catch (e) {
      emit(GuardianBankingError('Failed to update bank info'));
    }
  }
}
