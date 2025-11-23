
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/get_billing_summery_usecase.dart';
import 'billing_summery_event.dart';
import 'billing_summery_state.dart';


class BillingSummeryBloc extends Bloc<BillingSummeryEvent, BillingSummeryState> {
  final GetBillingSummaryUseCase useCase;

  BillingSummeryBloc(this.useCase) : super(BillingSummeryInitial()) {
    on<LoadBillingSummaryEvent>((event, emit) async {
      emit(BillingSummeryLoading());

      try {
        final summary = await useCase(childId: event.childId); // ← پاس دادن childId
        emit(BillingSummeryLoaded(summary));
      } catch (e) {
        emit(BillingSummeryError(e.toString()));
      }
    });
  }
}
