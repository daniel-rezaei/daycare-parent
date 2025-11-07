
import '../../../home_page/domain/entities/parent_contact_entity.dart';


abstract class ParentProfileState {}

class ParentProfileInitial extends ParentProfileState {}

class ParentProfileLoading extends ParentProfileState {}

class ParentProfileLoaded extends ParentProfileState {
  final ParentContactEntity parent;
  ParentProfileLoaded(this.parent);
}

class ParentProfileError extends ParentProfileState {
  final String message;
  ParentProfileError(this.message);
}
