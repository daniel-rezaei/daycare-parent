
class GuardianEntity {
  final String id;
  final bool isPrimary;
  final String relation;
  final String childId;
  final String contactId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? photo;

  GuardianEntity({
    required this.id,
    required this.isPrimary,
    required this.relation,
    required this.childId,
    required this.contactId,
    this.firstName,
    this.lastName,
    this.phone,
    this.photo,
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
