abstract class LoginEvent {}

class LoginHandleEvent extends LoginEvent {
  final String username;
  final String password;

  LoginHandleEvent({required this.username, required this.password});
}
