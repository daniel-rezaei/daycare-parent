
import '../entities/event_entity.dart';
import '../repositories/event_repository.dart';

class GetEventUseCase {
  final EventRepository repository;

  GetEventUseCase(this.repository);

  Future<List<EventEntity>> call() async {
    return await repository.getEvents();
  }
}
