
class DocumentEntity {
  final String id;
  final String? title;
  final String? description;
  final String? mimeType;
  final String? fileId;

  const DocumentEntity({
    required this.id,
    this.title,
    this.description,
    this.mimeType,
    this.fileId,
  });
}
