
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/get_billing_usecase.dart';
import 'billing_state.dart';
part 'billing_event.dart';


class BillingBloc extends Bloc<BillingEvent, BillingState> {
  final GetBillingUseCase getBillingUseCase;

  BillingBloc(this.getBillingUseCase) : super(BillingInitial()) {
    on<LoadBilling>((event, emit) async {
      emit(BillingLoading());
      try {
        final billings = await getBillingUseCase(childId: event.childId);
        emit(BillingLoaded(billings));
      } catch (e) {
        emit(BillingError(e.toString()));
      }
    });

  }
}
