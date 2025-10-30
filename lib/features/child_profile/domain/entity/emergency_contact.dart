

class EmergencyContact {
  final String id;
  final String childId;
  final String contactId;
  final String name;
  final String phone;
  final String? relationToChild;

  EmergencyContact({
    required this.id,
    required this.childId,
    required this.contactId,
    required this.name,
    required this.phone,
    this.relationToChild,
  });
}
