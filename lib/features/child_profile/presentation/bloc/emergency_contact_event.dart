
abstract class EmergencyContactsEvent {}

class LoadEmergencyContacts extends EmergencyContactsEvent {
  final String childId;

  LoadEmergencyContacts(this.childId);
}
class ToggleEmergencyCollapse extends EmergencyContactsEvent {}