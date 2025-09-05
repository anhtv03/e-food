import 'dart:convert';
import 'package:e_food/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    final res = await http.post(
      Uri.parse(RouteConstants.getUrl("/user/login")),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200 && body["status"] == 1) {
      return {
        'status': body["status"],
        'token': body["token"],
        'role': body["role"],
        'message': body["message"],
      };
    } else {
      throw Exception(body["message"]);
    }
  }

  static Future<Map<String, dynamic>> register(
    String username,
    String password,
    String fullName,
    String employeeCode,
  ) async {
    final res = await http.post(
      Uri.parse(RouteConstants.getUrl("/user/createNewUser")),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'fullname': fullName,
        'employeeCode': employeeCode,
        'role': 'user',
      }),
    );
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200 && body["status"] == 1) {
      return {
        'status': body["status"],
        'token': body["token"],
        'message': body["message"],
      };
    } else {
      throw Exception(body["message"]);
    }
  }
}
