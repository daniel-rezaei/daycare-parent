


import '../../domain/entities/parent_contact_entity.dart';

abstract class ParentContactState {}

class ParentContactInitial extends ParentContactState {}
class ParentContactLoading extends ParentContactState {}
class ParentContactLoaded extends ParentContactState {
  final ParentContactEntity contact;
  ParentContactLoaded(this.contact);
}
class ParentContactEmpty extends ParentContactState {}
class ParentContactError extends ParentContactState {
  final String message;
  ParentContactError(this.message);
}
