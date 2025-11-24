abstract class SharedMediaEvent {}

class LoadSharedMediaEvent extends SharedMediaEvent {
  final String childId;
  LoadSharedMediaEvent({required this.childId});
}

class SortSharedMediaEvent extends SharedMediaEvent {
  final String sortBy; // 'Newest', 'Oldest', 'Photo Only', 'Video Only', 'Top Activity'
  SortSharedMediaEvent({required this.sortBy});
}
class ApplyFilterSharedMediaEvent extends SharedMediaEvent {
  final Map<String, String> filters;
  ApplyFilterSharedMediaEvent({required this.filters});
}
class ApplySearchSharedMediaEvent extends SharedMediaEvent {
  final String query; // متن وارد شده در سرچ

  ApplySearchSharedMediaEvent({required this.query});
}
