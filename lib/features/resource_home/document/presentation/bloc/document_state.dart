


import '../../domain/entity/document_entity.dart';

abstract class DocumentState {}

class DocumentInitial extends DocumentState {}

class DocumentLoading extends DocumentState {}

class DocumentLoaded extends DocumentState {
  final String? parentId;
  final String? childId;
  final List<DocumentEntity> documents;
  DocumentLoaded({required this.documents,this.parentId, this.childId});
}

class DocumentError extends DocumentState {
  final String message;
  DocumentError(this.message);
}
