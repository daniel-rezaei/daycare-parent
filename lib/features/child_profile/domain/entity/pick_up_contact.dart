
class PickupContact {
  final String srcId;
  final String name;
  final String role;
  final String? contactId;
  final bool oneTime;

  PickupContact({
    required this.srcId,
    required this.name,
    required this.role,
    this.contactId,
    this.oneTime = false,
  });
}
