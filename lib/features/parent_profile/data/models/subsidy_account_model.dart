import '../../domain/entities/subsidy_account.dart';

class SubsidyAccountModel extends SubsidyAccount {
  SubsidyAccountModel({
    required String id,
    required String childId,
    required String status,
    DateTime? startDate,
    DateTime? endDate,
    double? amount,
  }) : super(id: id, childId: childId, status: status, startDate: startDate, endDate: endDate, amount: amount);

  factory SubsidyAccountModel.fromJson(Map<String, dynamic> json) {
    return SubsidyAccountModel(
      id: json['id'] as String,
      childId: json['child_id'] as String,
      status: json['Status'] as String? ?? '',
      startDate: json['Start_Date'] != null ? DateTime.parse(json['Start_Date']) : null,
      endDate: json['End_Date'] != null ? DateTime.parse(json['End_Date']) : null,
      amount: json['Amount'] != null ? double.tryParse(json['Amount'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'child_id': childId,
    'Status': status,
    'Start_Date': startDate?.toIso8601String(),
    'End_Date': endDate?.toIso8601String(),
    'Amount': amount?.toString(),
  };
}
