
abstract class BillingDocEvent {}

class LoadLatestStatement extends BillingDocEvent {
  final String guardianId;
  LoadLatestStatement(this.guardianId);
}

class LoadTaxYears extends BillingDocEvent {
  final String guardianId;
  LoadTaxYears(this.guardianId);
}

class LoadTaxStatementByYear extends BillingDocEvent {
  final String guardianId;
  final int year;
  LoadTaxStatementByYear(this.guardianId, this.year);
}