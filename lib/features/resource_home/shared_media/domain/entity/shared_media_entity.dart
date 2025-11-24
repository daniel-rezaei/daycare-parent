class SharedMediaEntity {
  final String id;
  final String caption;
  final String mediaType;
  final String? createdAt;
  final String? tags;
  final String? role;
  final String? activityType;
  final List<String>? privacy;
  final List<String>? fileIds;
  final Map<String, dynamic>? thumbnail;
  final String? uploadedBy;
  const SharedMediaEntity({
    required this.id,
    required this.caption,
    required this.mediaType,
    this.createdAt,
    this.activityType,
    this.privacy,
    this.tags,
    this.role,
    this.fileIds,
    this.thumbnail,
    this.uploadedBy,
  });
}
