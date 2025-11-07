


import '../../domain/entity/billing_summery_entity.dart';

abstract class BillingSummeryState {}

class BillingSummeryInitial extends BillingSummeryState {}

class BillingSummeryLoading extends BillingSummeryState {}

class BillingSummeryLoaded extends BillingSummeryState {
  final BillingSummaryEntity summary;
  BillingSummeryLoaded(this.summary);
}

class BillingSummeryError extends BillingSummeryState {
  final String message;
  BillingSummeryError(this.message);
}
