import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginPressed);
  }

  Future<void> _onLoginPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final user = await loginUseCase(event.email, event.password);
      if (user != null) {
        emit(LoginSuccess(user.id));
      } else {
        emit(LoginFailure('User not found'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
