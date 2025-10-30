

import '../entities/child_entity.dart';
import '../repositories/child_repository.dart';

class GetChildDataUseCase {
  final ChildRepository repository;

  GetChildDataUseCase(this.repository);

  Future<ChildEntity?> call() async {
    return await repository.getChildData();
  }
}
