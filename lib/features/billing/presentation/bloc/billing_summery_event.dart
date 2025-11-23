
abstract class BillingSummeryEvent {}

class LoadBillingSummaryEvent extends BillingSummeryEvent {
  final String childId;
  LoadBillingSummaryEvent(this.childId);
}