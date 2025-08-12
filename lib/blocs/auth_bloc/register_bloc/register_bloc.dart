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
        emit(RegisterError(message: 'Vui lòng nhập tên đầy đủ'));
        return;
      }

      if (event.employeeId.isEmpty) {
        emit(RegisterError(message: 'Vui lòng nhập mã nhân viên'));
        return;
      }

      if (event.username.isEmpty) {
        emit(RegisterError(message: 'Vui lòng nhập tên tài khoản'));
        return;
      }

      if (event.password.isEmpty) {
        emit(RegisterError(message: 'Vui lòng nhập mật khẩu'));
        return;
      }

      if (event.password.length < 6) {
        emit(RegisterError(message: 'Mật khẩu phải có ít nhất 6 ký tự'));
        return;
      }

      await Future.delayed(Duration(seconds: 2));
      emit(RegisterSuccess(message: 'Đăng ký thành công!'));
    } catch (e) {
      emit(RegisterError(message: 'Đã có lỗi xảy ra. Vui lòng thử lại.'));
    }
  }
}
