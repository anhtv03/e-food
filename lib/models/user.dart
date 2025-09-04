class User {
  final String username;
  final String fullName;
  final String? employeeCode;
  final String? role;

  User({
    required this.username,
    required this.fullName,
    this.employeeCode,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json["username"] as String,
      fullName: json["fullname"] as String,
      employeeCode: json["employee_code"] as String,
      role: json["role"] as String,
    );
  }
}
