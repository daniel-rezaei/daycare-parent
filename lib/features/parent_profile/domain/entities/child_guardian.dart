
class ChildGuardian {
  final String id;
  final String childId;
  final String contactId;
  final String? guardianId;
  final bool? isPrimaryPayer;

  ChildGuardian({
    required this.id,
    required this.childId,
    required this.contactId,
    this.guardianId,
    this.isPrimaryPayer,
  });
}
