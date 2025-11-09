
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/get_invoice_usecase.dart';
import '../../domain/usecase/get_payment_usecase.dart';
import 'billing_card_event.dart';
import 'billing_card_state.dart';

class BillingCardBloc extends Bloc<BillingCardEvent, BillingCardState> {
  final GetInvoicesUseCase getInvoicesUseCase;
  final GetPaymentsUseCase getPaymentsUseCase;

  BillingCardBloc({
    required this.getInvoicesUseCase,
    required this.getPaymentsUseCase,
  }) : super(BillingCardInitial()) {
    on<LoadBillingCardEvent>((event, emit) async {
      emit(BillingCardLoading());
      try {
        final invoices = await getInvoicesUseCase.call();
        final payments = await getPaymentsUseCase.call();
        emit(BillingCardLoaded(invoices: invoices, payments: payments));
      } catch (e) {
        emit(BillingCardError(e.toString()));
      }
    });
  }
}
