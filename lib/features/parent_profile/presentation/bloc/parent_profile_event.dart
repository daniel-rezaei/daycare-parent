
abstract class ParentProfileEvent {}

class LoadParentProfileEvent extends ParentProfileEvent {
  final String parentId;
  LoadParentProfileEvent({required this.parentId});
}
