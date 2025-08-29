import 'package:e_food/l10n/app_localizations.dart';
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
      if (event.fullName.isEmpty) {
        emit(NameError(message: localizations.fillFullName));
        return;
      }

      if (event.employeeId.isEmpty) {
        emit(EmployeeError(message: localizations.fillEmployeeId));
        return;
      }

      if (event.username.isEmpty) {
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

      await Future.delayed(Duration(seconds: 2));
      emit(RegisterSuccess(message: localizations.registrationSuccessful));
    } catch (e) {
      emit(RegisterError(message: localizations.errorOccurred));
    }
  }
}
