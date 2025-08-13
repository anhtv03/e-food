abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message;

  RegisterSuccess({required this.message});
}

class RegisterError extends RegisterState {
  final String message;

  RegisterError({required this.message});
}

class NameError extends RegisterState {
  final String message;

  NameError({required this.message});
}

class EmployeeError extends RegisterState {
  final String message;

  EmployeeError({required this.message});
}

class UsernameError extends RegisterState {
  final String message;

  UsernameError({required this.message});
}

class PasswordError extends RegisterState {
  final String message;

  PasswordError({required this.message});
}
