
import '../entity/pick_up_contact.dart';
import '../repository/pick_up_repository.dart';

class GetAuthorizedPickups {
  final PickupRepository repository;

  GetAuthorizedPickups(this.repository);

  Future<List<PickupContact>> call(String childId) async {
    return await repository.getAuthorizedPickups(childId);
  }
}
