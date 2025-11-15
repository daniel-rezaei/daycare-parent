// abstract class ChildEvent {}
//
// class LoadChildData extends ChildEvent {}
//
// class UpdateSelectedAvatar extends ChildEvent {
//   final String? avatar;
//   UpdateSelectedAvatar(this.avatar);
// }

abstract class ChildEvent {}

class LoadChildren extends ChildEvent {}

class SelectChild extends ChildEvent {
  final int index;
  SelectChild(this.index);
}
