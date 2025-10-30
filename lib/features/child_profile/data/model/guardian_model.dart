
import '../../domain/entity/guardian_entity.dart';

class GuardianModel extends GuardianEntity {
  GuardianModel({
    required String id,
    required bool isPrimary,
    required String relation,
    required String childId,
    required String contactId,
    String? firstName,
    String? lastName,
    String? phone,
    String? photo,
  }) : super(
    id: id,
    isPrimary: isPrimary,
    relation: relation,
    childId: childId,
    contactId: contactId,
    firstName: firstName,
    lastName: lastName,
    phone: phone,
    photo: photo,
  );

  // JSON Guardian + JSON Contact
  factory GuardianModel.fromJson(Map<String, dynamic> guardianJson, Map<String, dynamic>? contactJson) {
    return GuardianModel(
      id: guardianJson['id'] ?? '',
      isPrimary: guardianJson['Primary'] ?? false,
      relation: guardianJson['relation'] ?? '',
      childId: guardianJson['child_id'] ?? '',
      contactId: guardianJson['contact_id'] ?? '',
      firstName: contactJson?['first_name'],
      lastName: contactJson?['last_name'],
      phone: contactJson?['Phone'],
      photo: guardianJson['photo'] ?? contactJson?['photo'],
    );
  }
}
