

import 'package:parent_app/core/network/dio_client.dart';

import '../../domain/entity/emergency_contact.dart';
import '../../domain/repository/emergency_contact_repository.dart';

class EmergencyContactRepositoryImpl implements EmergencyContactRepository {
  final DioClient dioClient;

  EmergencyContactRepositoryImpl({required this.dioClient});

  @override
  Future<int> getActiveContactsCount(String childId) async {
    final response = await dioClient.get('/items/Child_Emergency_Contact');
    final data = response.data['data'] as List;
    final filtered = data.where((cec) {
      return cec['child_id'] == childId &&
          cec['is_active'] == true &&
          (cec['start_date'] == null || DateTime.parse(cec['start_date']).isBefore(DateTime.now())) &&
          (cec['end_date'] == null || DateTime.parse(cec['end_date']).isAfter(DateTime.now()));
    }).toList();
    return filtered.length;
  }

  @override
  Future<List<EmergencyContact>> getActiveContacts(String childId) async {
    final cecResponse = await dioClient.get('/items/Child_Emergency_Contact');
    final contactsResponse = await dioClient.get('/items/Contacts');

    final cecData = cecResponse.data['data'] as List;
    final contactsData = contactsResponse.data['data'] as List;

    final List<EmergencyContact> contacts = [];

    for (var cec in cecData) {
      if (cec['child_id'] == childId &&
          cec['is_active'] == true &&
          (cec['start_date'] == null || DateTime.parse(cec['start_date']).isBefore(DateTime.now())) &&
          (cec['end_date'] == null || DateTime.parse(cec['end_date']).isAfter(DateTime.now()))) {
        final contact = contactsData.firstWhere((c) => c['id'] == cec['contact_id']);
        contacts.add(
          EmergencyContact(
            id: cec['id'],
            childId: cec['child_id'],
            contactId: cec['contact_id'],
            name: '${contact['first_name']} ${contact['last_name']}',
            phone: contact['Phone'],
            relationToChild: cec['relation_to_child'],
          ),
        );
      }
    }

    contacts.sort((a, b) => a.name.compareTo(b.name)); // مشابه ORDER BY
    return contacts;
  }
}
