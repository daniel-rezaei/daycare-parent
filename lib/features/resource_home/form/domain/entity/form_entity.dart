class FormAssignmentEntity {
  final String id;
  final String title;
  final String? description;
  final String status;
  final DateTime? dueAt;

  const FormAssignmentEntity({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.dueAt,
  });
}
