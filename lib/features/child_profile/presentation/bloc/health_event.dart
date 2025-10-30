
abstract class HealthEvent {}

class LoadHealthCounts extends HealthEvent {
  final String childId;
  LoadHealthCounts(this.childId);
}

class LoadHealthList extends HealthEvent {
  final String childId;
  final String key;
  LoadHealthList({required this.childId, required this.key});
}
