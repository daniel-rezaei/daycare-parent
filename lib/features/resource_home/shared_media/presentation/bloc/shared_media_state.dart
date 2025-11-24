import '../../domain/entity/shared_media_entity.dart';
import '../widgets/media_grid_item.dart';

abstract class SharedMediaState {}

class SharedMediaInitial extends SharedMediaState {}

class SharedMediaLoading extends SharedMediaState {}

class SharedMediaLoaded extends SharedMediaState {
  final List<SharedMediaEntity> media;
  final List<MediaItem> mediaItems;

  SharedMediaLoaded({
    required this.media,
    required this.mediaItems,
  });
}

class SharedMediaError extends SharedMediaState {
  final String message;
  SharedMediaError(this.message);
}
