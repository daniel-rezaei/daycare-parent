


import '../../domain/entity/shared_media_entity.dart';

abstract class SharedMediaState {}

class SharedMediaInitial extends SharedMediaState {}

class SharedMediaLoading extends SharedMediaState {}

class SharedMediaLoaded extends SharedMediaState {
  final List<SharedMediaEntity> media;
  SharedMediaLoaded(this.media);
}

class SharedMediaError extends SharedMediaState {
  final String message;
  SharedMediaError(this.message);
}
