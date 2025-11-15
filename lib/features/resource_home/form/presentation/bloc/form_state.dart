import '../../domain/entity/form_entity.dart';

abstract class FormState {}

class FormInitial extends FormState {}

class FormLoading extends FormState {}

class FormLoaded extends FormState {
  final List<FormAssignmentEntity> assignments;
  FormLoaded(this.assignments);
}

class FormError extends FormState {
  final String message;
  FormError(this.message);
}
