import '../../domain/entities/parent_contact_entity.dart';

class ParentContactModel extends ParentContactEntity {
  ParentContactModel({
    required String id,
    String? firstName,
    String? lastName,
    String? email,
    String? street,
    String? postalCode,
    String? phone,
    String? photo,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    street: street,
    postalCode: postalCode,
    phone: phone,
    photo: photo,
  );

  factory ParentContactModel.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? '';
    final firstName = json['first_name'] ?? json['firstName'];
    final lastName = json['last_name'] ?? json['lastName'];
    final email = json['email'];
    final phone = json['Phone'];
    final street = json['street_address'];
    final postalCode = json['postal_code'];
    final photo = json['photo'];

    return ParentContactModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      street: street,
      postalCode: postalCode,
      photo: photo,
    );
  }
}
