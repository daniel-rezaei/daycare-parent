

import '../../domain/entity/emergency_contact.dart';

abstract class EmergencyContactsState {}

class EmergencyContactsInitial extends EmergencyContactsState {}

class EmergencyContactsLoading extends EmergencyContactsState {}

class EmergencyContactsLoaded extends EmergencyContactsState {
  final List<EmergencyContact> contacts;
  final bool isCollapsed;

  EmergencyContactsLoaded({required this.contacts, required this.isCollapsed});
}

class EmergencyContactsError extends EmergencyContactsState {
  final String message;
  EmergencyContactsError(this.message);
}
