// data/models/subsidy_account_model.dart
import '../../domain/entities/subsidy_account_entity.dart';

class SubsidyAccountModel extends SubsidyAccountEntity {
  SubsidyAccountModel({
    required super.id,
    required super.status,
    super.providerName,
    super.startDate,
    super.endDate,
    super.childId,
    super.guardianId,
  });

  factory SubsidyAccountModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? s) {
      if (s == null) return null;
      try {
        return DateTime.parse(s);
      } catch (_) {
        return null;
      }
    }

    return SubsidyAccountModel(
      id: json['id'] ?? '',
      status: json['Status'] ?? 'unknown',
      providerName: json['Provider_Name'],
      startDate: parseDate(json['Start_Date']),
      endDate: parseDate(json['End_Date']),
      childId: json['child_id'],
      guardianId: json['guardian_id'],
    );
  }
}
