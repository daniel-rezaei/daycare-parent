


import '../../domain/entity/document_entity.dart';

class DocumentModel extends DocumentEntity {
  const DocumentModel({
    required super.id,
    super.title,
    super.description,
    super.mimeType,
    super.fileId,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    final files = json['file'];
    String? fileId;
    if (files is List && files.isNotEmpty) {
      fileId = files.first.toString();
    }

    return DocumentModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      mimeType: json['mime_type'], // از کوئری یا از فایل
      fileId: fileId,
    );
  }
}
