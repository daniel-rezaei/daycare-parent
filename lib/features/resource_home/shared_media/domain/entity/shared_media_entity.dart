class SharedMediaEntity {
  final String id;
  final String caption;
  final String mediaType;
  final String? createdAt;
  final String? tags;
  final String? activityType; // اضافه شد
  final List<String>? privacy;
  final List<String>? fileIds;

  const SharedMediaEntity({
    required this.id,
    required this.caption,
    required this.mediaType,
    this.createdAt,
    this.activityType,
    this.privacy,
    this.tags,
    this.fileIds,
  });
}
