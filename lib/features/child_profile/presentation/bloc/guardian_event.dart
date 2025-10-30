
abstract class GuardianEvent {}
class LoadPrimaryGuardians extends GuardianEvent {
  final String childId; // non-nullable
  LoadPrimaryGuardians({required this.childId});
}
