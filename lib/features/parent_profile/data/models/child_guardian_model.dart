
import '../../domain/entities/child_guardian.dart';

class ChildGuardianModel extends ChildGuardian {
  ChildGuardianModel({
    required String id,
    required String childId,
    required String contactId,
    String? guardianId,
    bool? isPrimaryPayer,
  }) : super(id: id, childId: childId, contactId: contactId, guardianId: guardianId, isPrimaryPayer: isPrimaryPayer);

  factory ChildGuardianModel.fromJson(Map<String, dynamic> json) {
    return ChildGuardianModel(
      id: json['id'] as String,
      childId: json['child_id'] as String,
      contactId: json['contact_id'] as String,
      guardianId: json['guardian_id'] as String?,
      isPrimaryPayer: json['is_primary_payer'] == null ? null : (json['is_primary_payer'] == true),
    );
  }
}
