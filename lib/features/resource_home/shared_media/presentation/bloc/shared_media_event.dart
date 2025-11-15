
abstract class SharedMediaEvent {}

class LoadSharedMediaEvent extends SharedMediaEvent {
  final String childId;
  LoadSharedMediaEvent({required this.childId});
}
