
import '../../domain/entity/pick_up_contact.dart';

abstract class PickupState {}

class PickupLoading extends PickupState {}

class PickupLoaded extends PickupState {
  final List<PickupContact> pickups;

  PickupLoaded(this.pickups);
}

class PickupError extends PickupState {
  final String message;

  PickupError(this.message);
}
