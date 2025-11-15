import '../../domain/entity/form_entity.dart';

class FormAssignmentModel extends FormAssignmentEntity {
  const FormAssignmentModel({
    required super.id,
    required super.title,
    super.description,
    required super.status,
    super.dueAt,
  });

  factory FormAssignmentModel.fromJson(
      Map<String, dynamic> assignmentJson,
      Map<String, dynamic> templateJson) {
    return FormAssignmentModel(
      id: assignmentJson['id'] ?? '',
      title: templateJson['name'] ?? 'بدون عنوان',
      description: templateJson['description'],
      status: assignmentJson['status'] ?? 'not_started',
      dueAt: assignmentJson['due_at'] != null
          ? DateTime.tryParse(assignmentJson['due_at'])
          : null,
    );
  }
}
