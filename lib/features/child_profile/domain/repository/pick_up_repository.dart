
import '../entity/pick_up_contact.dart';

abstract class PickupRepository {
  Future<List<PickupContact>> getAuthorizedPickups(String childId);
}