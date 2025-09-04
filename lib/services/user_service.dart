import 'dart:convert';
import 'package:e_food/constants/api_constants.dart';
import 'package:e_food/models/DTOs/response_base.dart';
import 'package:e_food/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<ResponseBase<User>> getUser(String token) async {
    final res = await http.get(
      Uri.parse(RouteConstants.getUrl("/user/getUserInfo")),
      headers: {'Authorization': 'Bearer $token'},
    );
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      return ResponseBase.fromJson(body, User.fromJson);
    } else {
      throw Exception(body['message']);
    }
  }
}
