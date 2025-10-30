

import '../../domain/entities/billing_entity.dart';

abstract class BillingState {}

class BillingInitial extends BillingState {}

class BillingLoading extends BillingState {}

class BillingLoaded extends BillingState {
  final List<BillingEntity> billings;
  BillingLoaded(this.billings);
}

class BillingError extends BillingState {
  final String message;
  BillingError(this.message);
}
