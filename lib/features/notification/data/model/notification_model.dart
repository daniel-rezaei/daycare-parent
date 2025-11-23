import '../../domain/entity/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    super.title,
    super.description,
    super.senderRole,
    super.type,
    super.sourceTable,
    super.sourceId,
    super.createdAt,
    super.isRead,
    super.recipientUserId,
    super.childId,
    super.senderContactId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      senderRole: json['sender_role']?.toString(),
      type: json['type']?.toString(),
      sourceTable: json['source_table']?.toString(),
      sourceId: json['source_id']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      isRead: json['is_read'] == true,
      recipientUserId: json['recipient_user_id']?.toString(),
      childId: json['child_id']?.toString(),
      senderContactId: json['sender_contact_id']?.toString(),
    );
  }
}
