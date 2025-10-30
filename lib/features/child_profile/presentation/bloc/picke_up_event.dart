
abstract class PickupEvent {}

class LoadAuthorizedPickups extends PickupEvent {
  final String childId;

  LoadAuthorizedPickups(this.childId);
}
