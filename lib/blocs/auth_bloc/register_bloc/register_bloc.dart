import 'package:e_food/l10n/app_localizations.dart';
import 'package:e_food/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final BuildContext context;

  RegisterBloc({required this.context}) : super(RegisterInitial()) {
    on<RegisterHandleEvent>(_onRegisterHandleEvent);
  }

  Future<void> _onRegisterHandleEvent(
    RegisterHandleEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    final localizations = AppLocalizations.of(context);

    try {
      if (event.fullName.trim().isEmpty) {
        emit(NameError(message: localizations.fillFullName));
        return;
      }

      if (event.employeeId.trim().isEmpty) {
        emit(EmployeeError(message: localizations.fillEmployeeId));
        return;
      }

      if (event.username.trim().isEmpty) {
        emit(UsernameError(message: localizations.fillUsername));
        return;
      }

      if (event.password.isEmpty) {
        emit(PasswordError(message: localizations.fillPassword));
        return;
      }

      if (event.password.length < 6) {
        emit(PasswordError(message: localizations.passwordMinCharacters));
        return;
      }

      await AuthService.register(
        event.username,
        event.password,
        event.fullName,
        event.employeeId,
      );

      await Future.delayed(Duration(seconds: 2));
      emit(RegisterSuccess(message: localizations.registrationSuccessful));
    } catch (e) {
      String message = e.toString().replaceAll('Exception: ', '');
      final errorMessages = {
        'Tên đăng nhập đã tồn tại': localizations.usernameExisted,
        'Mã nhân viên đã tồn tại, vui lòng kiểm tra lại!':
            localizations.employeeCodeExisted,
      };
      emit(
        RegisterError(
          message: errorMessages[message] ?? localizations.errorOccurred,
        ),
      );
    }
  }
}
