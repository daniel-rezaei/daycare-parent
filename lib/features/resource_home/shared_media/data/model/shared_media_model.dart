import '../../domain/entity/shared_media_entity.dart';

class SharedMediaModel extends SharedMediaEntity {
  const SharedMediaModel({
    required super.id,
    required super.caption,
    required super.mediaType,
    required super.createdAt,
    required super.activityType,
    required super.privacy,
    super.tags,
    super.fileIds,
    super.thumbnail,
  });

  factory SharedMediaModel.fromJson(Map<String, dynamic> json) {
    final files = (json['file'] as List?)
        ?.map((f) {
      if (f is Map<String, dynamic>) {
        return f['directus_files_id'] ?? f['id'];
      }
      return f;
    })
        .map((e) => e.toString())
        .toList();

    return SharedMediaModel(
      id: json['id'] ?? '',
      caption: json['caption'] ?? '',
      mediaType: json['media_type'] ?? '',
      createdAt: json['created_at'] ?? '',
      activityType: json['activity_type'],

      /// ⭐ FIX HERE → privacy همیشه لیست است
      privacy: (json['privacy'] is List)
          ? (json['privacy'] as List).map((e) => e.toString()).toList()
          : null,

      tags: json['tags'],
      fileIds: files,
      thumbnail: json['thumbnail'] != null ? Map<String, dynamic>.from(json['thumbnail']) : null,
    );
  }
}
