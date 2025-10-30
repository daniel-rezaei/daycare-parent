
abstract class HealthState {}
class HealthInitial extends HealthState {}

class HealthLoading extends HealthState {}

class HealthLoaded extends HealthState {
  final Map<String, int> counts;
  final Map<String, List<dynamic>> lists;

  HealthLoaded(this.counts, this.lists);
}

class HealthError extends HealthState {
  final String message;
  HealthError(this.message);
}
