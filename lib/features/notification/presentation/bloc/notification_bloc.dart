
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/get_notification_usecase.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationBloc(this.getNotificationsUseCase) : super(NotificationInitial()) {
    on<LoadNotificationsEvent>((event, emit) async {
      emit(NotificationLoading());
      try {
        final notifications = await getNotificationsUseCase(event.childId);
        emit(NotificationLoaded(notifications));
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });
  }
}
