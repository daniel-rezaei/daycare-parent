import '../../../../core/network/dio_client.dart';
import '../../domain/entity/pick_up_contact.dart';
import '../../domain/repository/pick_up_repository.dart';

class PickupRepositoryImpl implements PickupRepository {
  final DioClient dioClient;

  PickupRepositoryImpl(this.dioClient);

  @override
  Future<List<PickupContact>> getAuthorizedPickups(String childId) async {
    // 1- Fetch Child Guardians
    final cgResponse = await dioClient.get('/items/Child_Guardian?child_id=$childId');
    final contactsResponse = await dioClient.get('/items/Contacts');
    final paResponse = await dioClient.get('/items/PickupAuthorization?child_id=$childId');

    final contactsMap = {
      for (var c in contactsResponse.data['data']) c['id']: c,
    };

    List<PickupContact> result = [];

    // --- 1- Guardians with pickup permission ---
    for (var cg in cgResponse.data['data']) {
      if (cg['child_id'] != childId) continue; // فقط رکوردهای این چایلد
      final contactId = cg['contact_id'];
      final pickupAuthorized = cg['pickup_authorized'] ?? true; // اگر null را TRUE فرض کنیم
      if (pickupAuthorized && contactId != null) {
        final contact = contactsMap[contactId];
        if (contact != null) {
          result.add(PickupContact(
            srcId: cg['id'],
            name: "${contact['first_name']} ${contact['last_name']}",
            role: cg['relation'] ?? '',
            contactId: contactId,
            oneTime: false,
          ));
        }
      }
    }

    // --- 2- Pickup Authorizations ---
    for (var pa in paResponse.data['data']) {
      if (pa['child_id'] != childId) continue; // فقط رکوردهای این چایلد
      final startDate = pa['start_date'] != null ? DateTime.parse(pa['start_date']) : null;
      final endDate = pa['end_date'] != null ? DateTime.parse(pa['end_date']) : null;
      final now = DateTime.now();
      final active = (pa['active'] == true || pa['status'] == 'active') &&
          (startDate == null || !startDate.isAfter(now)) &&
          (endDate == null || !endDate.isBefore(now));

      if (!active) continue;

      final contactId = pa['authorized_contact_id'];
      String name = pa['display_name_snapshot'] ?? '';
      if (contactId != null && contactsMap.containsKey(contactId)) {
        final contact = contactsMap[contactId];
        name = "${contact['first_name']} ${contact['last_name']}";
      }

      result.add(PickupContact(
        srcId: pa['id'],
        name: name,
        role: pa['relation_to_child'] ?? '',
        contactId: contactId,
        oneTime: pa['one_time'] ?? false,
      ));
    }

    // --- Merge/Dedupe by contactId ---
    final Map<String?, PickupContact> merged = {};
    for (var pc in result) {
      if (pc.contactId != null && merged.containsKey(pc.contactId)) {
        // اگر قبلا هست، oneTime را OR کنیم
        merged[pc.contactId] = PickupContact(
          srcId: merged[pc.contactId]!.srcId,
          name: merged[pc.contactId]!.name,
          role: merged[pc.contactId]!.role,
          contactId: pc.contactId,
          oneTime: merged[pc.contactId]!.oneTime || pc.oneTime,
        );
      } else {
        merged[pc.contactId] = pc;
      }
    }

    return merged.values.toList();
  }
}
