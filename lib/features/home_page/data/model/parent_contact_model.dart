
import '../../domain/entities/parent_contact_entity.dart';

class ParentContactModel extends ParentContactEntity {
  ParentContactModel({
    required String id,
    String? firstName,
    String? lastName,
  }) : super(id: id, firstName: firstName, lastName: lastName);

  factory ParentContactModel.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? '';
    final firstName = json['first_name'] ?? json['firstName'];
    final lastName = json['last_name'] ?? json['lastName'];

    return ParentContactModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
