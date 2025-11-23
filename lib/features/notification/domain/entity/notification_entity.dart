
class NotificationEntity {
  final String id;
  final String? title;
  final String? description;
  final String? senderRole;
  final String? type;
  final String? sourceTable;
  final String? sourceId;
  final DateTime? createdAt;
  final bool isRead;
  final String? recipientUserId;
  final String? childId;
  final String? senderContactId;

  NotificationEntity({
    required this.id,
    this.title,
    this.description,
    this.senderRole,
    this.type,
    this.sourceTable,
    this.sourceId,
    this.createdAt,
    this.isRead = false,
    this.recipientUserId,
    this.childId,
    this.senderContactId,
  });
}
