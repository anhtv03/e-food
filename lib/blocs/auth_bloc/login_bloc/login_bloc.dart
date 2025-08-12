import 'package:e_food/blocs/auth_bloc/login_bloc/login_event.dart';
import 'package:e_food/blocs/auth_bloc/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginHandleEvent>(_handleLogin);
  }

  Future<void> _handleLogin(
    LoginHandleEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      if (event.username.isEmpty) {
        emit(LoginError(message: 'Tên đăng nhập không được để trống'));
        return;
      }

      if (event.password.isEmpty) {
        emit(LoginError(message: 'Mật khẩu không được để trống'));
        return;
      }

      String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNjYxNjUwMDYxMjQzYmNkZjE1MDQzNGUxIiwiRnVsbE5hbWUiOiJBbmhUViIsImlhdCI6MTcxMjczODMxMCwiZXhwIjozMzI0ODczODMxMH0.FP-4RIKCoAWRMccM1ls14sr4656q_3mk17yUeVQAnZE';
      if (event.username == "ad" && event.password == "123") {
        // await TokenService.saveToken('user', token);
        emit(LoginSuccess(token: token));
      } else {
        emit(LoginError(message: 'Bạn nhập sai tên tài khoản hoặc mật khẩu!'));
      }

      // final result = await AuthService.login(event.username, event.password);
      //
      // if (result.status == 1) {
      //   await TokenService.saveToken('user', result.data.token);
      //   emit(LoginSuccess(token: result.data.token));
      // }
    } catch (e) {
      String message = e.toString().replaceAll('Exception: ', '');
      emit(
        LoginError(
          message:
              message == 'Incorrect password' || message == 'Username not found'
                  ? 'Bạn nhập sai tên tài khoản hoặc mật khẩu!'
                  : 'Đăng nhập thất bại do lỗi hệ thống',
        ),
      );
    }
  }
}
