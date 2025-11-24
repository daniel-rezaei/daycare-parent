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
    super.role,
    super.fileIds,
    super.thumbnail,
    super.uploadedBy,
  });

  factory SharedMediaModel.fromJson(Map<String, dynamic> json) {

    print("====== RAW JSON FROM SERVER ======");
    print(json);

    print("🔥 uploaded_by raw = ${json['uploaded_by']}");
    print("🔥 uploaded_by type = ${json['uploaded_by']?.runtimeType}");

    final files = (json['file'] as List?)
        ?.map((f) {
      if (f is Map<String, dynamic>) {
        return f['directus_files_id'] ?? f['id'];
      }
      return f;
    })
        .map((e) => e.toString())
        .toList();

    final uploadedByParsed = json['uploaded_by'] is Map
        ? json['uploaded_by']['id']?.toString()
        : json['uploaded_by']?.toString();

    print("🔥 parsed uploadedBy = $uploadedByParsed");

    return SharedMediaModel(
      id: json['id'] ?? '',
      caption: json['caption'] ?? '',
      mediaType: json['media_type'] ?? '',
      createdAt: json['created_at'] ?? '',
      activityType: json['activity_type'],
      privacy: (json['privacy'] is List)
          ? (json['privacy'] as List).map((e) => e.toString()).toList()
          : null,
      tags: json['tags'],
      role: json['role'],
      fileIds: files,
      thumbnail: json['thumbnail'] != null ? Map<String, dynamic>.from(json['thumbnail']) : null,

      uploadedBy: uploadedByParsed,
    );
  }


}
