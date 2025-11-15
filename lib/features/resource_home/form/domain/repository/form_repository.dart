import '../../../../home_page/presentation/bloc/child_state.dart';
import '../entity/form_entity.dart';

abstract class FormRepository {
  Future<List<FormAssignmentEntity>> getFormAssignments({
    required String childId,
    required ChildListLoaded childState,
  });
}
