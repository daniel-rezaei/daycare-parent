
import '../entity/shared_media_entity.dart';

abstract class SharedMediaRepository {
  Future<List<SharedMediaEntity>> getSharedMedia({
    required String childId,
  });
}
