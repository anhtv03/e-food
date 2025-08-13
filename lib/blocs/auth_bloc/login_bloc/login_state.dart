abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess({required this.token});
}

class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}

class UsernameError extends LoginState {
  final String message;

  UsernameError({required this.message});
}

class PasswordError extends LoginState {
  final String message;

  PasswordError({required this.message});
}
