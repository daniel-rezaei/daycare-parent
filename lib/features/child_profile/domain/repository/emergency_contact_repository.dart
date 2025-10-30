


import '../entity/emergency_contact.dart';

abstract class EmergencyContactRepository {
  Future<int> getActiveContactsCount(String childId);
  Future<List<EmergencyContact>> getActiveContacts(String childId);
}
