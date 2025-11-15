import '../repository/shared_media_repository.dart';
import '../entity/shared_media_entity.dart';

class GetSharedMediaUseCase {
  final SharedMediaRepository repository;

  GetSharedMediaUseCase(this.repository);

  Future<List<SharedMediaEntity>> call({required String childId}) {
    return repository.getSharedMedia(childId: childId);
  }
}
