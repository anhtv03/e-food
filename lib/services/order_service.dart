import 'dart:convert';
import 'package:e_food/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static Future<Map<String, dynamic>> createOrder(
    String token,
    String foodId,
  ) async {
    final res = await http.post(
      Uri.parse(RouteConstants.getUrl('/orders/createOrder/$foodId')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'quantity': 1, 'statusOrder': 'ordered'}),
    );

    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 201) {
      return {
        'status': body["status"],
        'orderId': body["orderId"],
        'message': body["message"],
      };
    } else {
      throw Exception(body['message']);
    }
  }

  static Future<Map<String, dynamic>> cancelOrder(
    String token,
    String foodId,
  ) async {
    final res = await http.delete(
      Uri.parse(RouteConstants.getUrl('/orders/cancelOrder/$foodId')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      return {'status': body["status"], 'message': body["message"]};
    } else {
      throw Exception(body['message']);
    }
  }
}
