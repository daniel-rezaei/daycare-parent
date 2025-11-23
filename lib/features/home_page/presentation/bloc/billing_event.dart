part of 'billing_bloc.dart';

abstract class BillingEvent {}

class LoadBilling extends BillingEvent {
  final String childId;
  LoadBilling(this.childId);
}
