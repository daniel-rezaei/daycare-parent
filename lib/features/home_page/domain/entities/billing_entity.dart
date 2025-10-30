import 'package:intl/intl.dart';

class BillingEntity {
  final String? balanceMinor;
  final String? status;
  final DateTime? dueDate;

  BillingEntity({
    this.balanceMinor,
    this.status,
    this.dueDate,
  });

  String get formattedDueDate {
    if (dueDate == null) return "";
    final DateFormat formatter = DateFormat("MMM d, yyyy");
    return formatter.format(dueDate!);
  }

  factory BillingEntity.fromJson(Map<String, dynamic> json) {
    return BillingEntity(
      balanceMinor: json["balance_minor"] ?? "0",
      status: json["status"] ?? "",
      dueDate: json["due_date"] != null ? DateTime.parse(json["due_date"]) : null,
    );
  }
}
