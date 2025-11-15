import '../../domain/entity/form_entity.dart';
import '../../domain/repository/form_repository.dart';
import '../../../../home_page/presentation/bloc/child_state.dart';

class GetFormAssignmentsUseCase {
  final FormRepository repository;

  GetFormAssignmentsUseCase(this.repository);

  Future<List<FormAssignmentEntity>> call({
    required String childId,
    required ChildListLoaded childState,
  }) {
    return repository.getFormAssignments(
      childId: childId,
      childState: childState,
    );
  }
}
