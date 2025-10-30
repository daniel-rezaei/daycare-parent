
import '../entity/guardian_entity.dart';

abstract class GuardianRepository {
  Future<List<GuardianEntity>> getPrimaryGuardiansForChild({required String childId, int limit = 2});
}