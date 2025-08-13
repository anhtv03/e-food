import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterHandleEvent>(_onRegisterHandleEvent);
  }

  Future<void> _onRegisterHandleEvent(
    RegisterHandleEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    try {
      if (event.fullName.isEmpty) {
        emit(NameError(message: 'Vui lòng nhập tên đầy đủ'));
        return;
      }

      if (event.employeeId.isEmpty) {
        emit(EmployeeError(message: 'Vui lòng nhập mã nhân viên'));
        return;
      }

      if (event.username.isEmpty) {
        emit(UsernameError(message: 'Vui lòng nhập tên tài khoản'));
        return;
      }

      if (event.password.isEmpty) {
        emit(PasswordError(message: 'Vui lòng nhập mật khẩu'));
        return;
      }

      if (event.password.length < 6) {
        emit(PasswordError(message: 'Mật khẩu phải có ít nhất 6 ký tự'));
        return;
      }

      await Future.delayed(Duration(seconds: 2));
      emit(RegisterSuccess(message: 'Đăng ký thành công!'));
    } catch (e) {
      emit(RegisterError(message: 'Đã có lỗi xảy ra. Vui lòng thử lại.'));
    }
  }
}
