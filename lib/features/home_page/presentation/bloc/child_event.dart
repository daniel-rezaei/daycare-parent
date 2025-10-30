abstract class ChildEvent {}

class LoadChildData extends ChildEvent {}

class UpdateSelectedAvatar extends ChildEvent {
  final String? avatar;
  UpdateSelectedAvatar(this.avatar);
}
