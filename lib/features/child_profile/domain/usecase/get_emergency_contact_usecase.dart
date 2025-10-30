


import '../entity/emergency_contact.dart';
import '../repository/emergency_contact_repository.dart';

class GetEmergencyContacts {
  final EmergencyContactRepository repository;

  GetEmergencyContacts(this.repository);

  Future<List<EmergencyContact>> call(String childId) async {
    return await repository.getActiveContacts(childId);
  }
}

class GetEmergencyContactsCount {
  final EmergencyContactRepository repository;

  GetEmergencyContactsCount(this.repository);

  Future<int> call(String childId) async {
    return await repository.getActiveContactsCount(childId);
  }
}
