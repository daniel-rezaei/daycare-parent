
import '../entities/child_entity.dart';

// abstract class ChildRepository {
//   Future<ChildEntity?> getChildData();
// }
abstract class ChildRepository {
  Future<List<ChildEntity>> getChildrenData();
}
