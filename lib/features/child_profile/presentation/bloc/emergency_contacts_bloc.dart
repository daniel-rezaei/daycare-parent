import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_emergency_contact_usecase.dart';
import 'emergency_contact_event.dart';
import 'emergency_contacts_state.dart';


class EmergencyContactsBloc extends Bloc<EmergencyContactsEvent, EmergencyContactsState> {
  final GetEmergencyContacts getContacts;
  final GetEmergencyContactsCount getContactsCount;
  bool _isCollapsed = true;

  EmergencyContactsBloc({required this.getContacts, required this.getContactsCount})
      : super(EmergencyContactsInitial()) {
    on<LoadEmergencyContacts>((event, emit) async {
      emit(EmergencyContactsLoading());
      try {
        final contacts = await getContacts(event.childId);
        emit(EmergencyContactsLoaded(contacts: contacts, isCollapsed: _isCollapsed));
      } catch (e) {
        emit(EmergencyContactsError(e.toString()));
      }
    });

    on<ToggleEmergencyCollapse>((event, emit) {
      if (state is EmergencyContactsLoaded) {
        _isCollapsed = !_isCollapsed;
        final current = state as EmergencyContactsLoaded;
        emit(EmergencyContactsLoaded(contacts: current.contacts, isCollapsed: _isCollapsed));
      }
    });
  }
}
