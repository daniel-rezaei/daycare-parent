
import '../entities/parent_contact_entity.dart';
import '../repositories/parent_repository.dart';

class GetParentContactUseCase {
  final ParentRepository repository;
  GetParentContactUseCase(this.repository);

  Future<ParentContactEntity?> call({
    required String currentUserId,
    String? childId,
  }) async {
    return await repository.getParentContactForCurrentUser(
      currentUserId: currentUserId,
      childId: childId,
    );
  }
}
