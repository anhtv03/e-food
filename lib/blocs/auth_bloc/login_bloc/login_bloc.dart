import 'package:e_food/blocs/auth_bloc/login_bloc/login_event.dart';
import 'package:e_food/blocs/auth_bloc/login_bloc/login_state.dart';
import 'package:e_food/l10n/app_localizations.dart';
import 'package:e_food/services/auth_service.dart';
import 'package:e_food/services/token_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BuildContext context;

  LoginBloc({required this.context}) : super(LoginInitial()) {
    on<LoginHandleEvent>(_handleLogin);
  }

  Future<void> _handleLogin(
    LoginHandleEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final localizations = AppLocalizations.of(context);

    try {
      if (event.username.isEmpty) {
        emit(UsernameError(message: localizations.usernameIsEmpty));
        return;
      }

      if (event.password.isEmpty) {
        emit(PasswordError(message: localizations.passwordIsEmpty));
        return;
      }

      final result = await AuthService.login(event.username, event.password);

      await TokenService.saveToken('user', result["token"]);
      emit(LoginSuccess(token: result["token"]));
    } catch (e) {
      String message = e.toString().replaceAll('Exception: ', '');
      emit(
        LoginError(
          message:
              message == 'Sai mật khẩu' || message == 'Sai tên đăng nhập'
                  ? localizations.incorrectInputLogin
                  : localizations.loginFailedServer,
        ),
      );
    }
  }
}
