abstract class RegisterEvent {}

class RegisterHandleEvent extends RegisterEvent {
  final String fullName;
  final String employeeId;
  final String username;
  final String password;

  RegisterHandleEvent({
    required this.fullName,
    required this.employeeId,
    required this.username,
    required this.password,
  });
}
