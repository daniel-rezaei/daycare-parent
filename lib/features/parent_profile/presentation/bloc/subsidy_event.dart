
abstract class SubsidyEvent {}

class LoadSubsidyStatusEvent extends SubsidyEvent {
  final String contactId;
  LoadSubsidyStatusEvent(this.contactId);
}
