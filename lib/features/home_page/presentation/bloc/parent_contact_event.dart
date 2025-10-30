
abstract class ParentContactEvent {}
class LoadParentContact extends ParentContactEvent {
  final String currentUserId;
  final String? childId;
  LoadParentContact({required this.currentUserId, this.childId});
}
