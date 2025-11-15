import '../../../../home_page/presentation/bloc/child_state.dart';

abstract class FormEvent {}

class LoadFormEvent extends FormEvent {
  final String childId;
  final ChildListLoaded childState;

  LoadFormEvent({required this.childId, required this.childState});
}
