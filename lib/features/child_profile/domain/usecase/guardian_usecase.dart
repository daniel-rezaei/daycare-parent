
// get_primary_guardians_usecase.dart
import '../../domain/entity/guardian_entity.dart';
import '../../domain/repository/guardian_repository.dart';

class GetPrimaryGuardiansUseCase {
  final GuardianRepository repository;
  GetPrimaryGuardiansUseCase(this.repository);

  Future<List<GuardianEntity>> call({required String childId}) async {
    return await repository.getPrimaryGuardiansForChild(childId: childId);
  }
}
