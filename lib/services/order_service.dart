import 'dart:convert';
import 'package:e_food/constants/api_constants.dart';
import 'package:e_food/models/history.dart';
import 'package:e_food/models/meal_statistic.dart';
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

  static Future<Map<String, dynamic>> getAllOrdersByUserId(String token) async {
    final res = await http.get(
      Uri.parse(RouteConstants.getUrl("/orders/getAllOrdersByUserId")),
      headers: {'Authorization': 'Bearer $token'},
    );
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      return {
        'success': body["success"],
        'data':
            (body['data'] as List<dynamic>)
                .map((item) => OrderHistory.fromJson(item))
                .toList(),
      };
    } else {
      throw Exception(body['message']);
    }
  }

  static Future<Map<String, dynamic>> getAllOrderByUserIdForMonthYear(
    String token,
    int month,
    int year,
  ) async {
    final res = await http.post(
      Uri.parse(
        RouteConstants.getUrl("/orders/getAllOrderByUserIdForMonthYear"),
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'month': month, 'year': year}),
    );
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      return {
        'status': body["status"],
        'data':
            (body['data'] as List<dynamic>)
                .map((item) => MealStatistic.fromJson(item))
                .toList(),
      };
    } else {
      throw Exception(body['message']);
    }
  }
}
