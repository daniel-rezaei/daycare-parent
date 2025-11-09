
abstract class BillingCardState {}

class BillingCardInitial extends BillingCardState {}

class BillingCardLoading extends BillingCardState {}

class BillingCardLoaded extends BillingCardState {
  final List invoices;
  final List payments;

  BillingCardLoaded({required this.invoices, required this.payments});
}

class BillingCardError extends BillingCardState {
  final String message;

  BillingCardError(this.message);
}
