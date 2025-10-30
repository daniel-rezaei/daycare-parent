
import '../entities/parent_contact_entity.dart';

abstract class ParentRepository {
  Future<ParentContactEntity?> getParentContactForCurrentUser({
    required String currentUserId,
    String? childId,
  });
}

