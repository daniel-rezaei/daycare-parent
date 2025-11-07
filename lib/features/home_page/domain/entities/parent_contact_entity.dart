class ParentContactEntity {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? street;
  final String? postalCode;
  final String? photo;

  ParentContactEntity({
    required this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.photo,
    this.postalCode,
    this.street,
  });

  String get fullName {
    final f = (firstName ?? '').trim();
    final l = (lastName ?? '').trim();
    if (f.isEmpty && l.isEmpty) return '';
    if (f.isEmpty) return l;
    if (l.isEmpty) return f;
    return '$f $l';
  }
}
