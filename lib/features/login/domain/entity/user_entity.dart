class UserEntity {
  final String id;
  final String email;
  final String status;
  final String? contactId;
  final String? guardianId;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final String postalCode;
  final String photo;

  const UserEntity({
    required this.id,
    required this.email,
    required this.status,
    this.contactId,
    this.guardianId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.postalCode,
    required this.photo,
  });
}
