import 'dart:convert';
import 'package:e_food/constants/api_constants.dart';
import 'package:e_food/models/DTOs/response_base.dart';
import 'package:e_food/models/meal.dart';
import 'package:http/http.dart' as http;

class FoodService {
  static Future<ResponseList<Meal>> getFoodItemsOnThisWeek(String token) async {
    final res = await http.get(
      Uri.parse(RouteConstants.getUrl("/foodItems/getFoodItemsOnThisWeek")),
      headers: {'Authorization': 'Bearer $token', 'accept': 'application/json'},
    );
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    print('FoodService: ${body}');
    if (res.statusCode == 200) {
      return ResponseList.fromJson(
        body,
        (data) => Meal.fromJson(data as Map<String, dynamic>),
      );
    } else {
      throw Exception(body['message']);
    }
  }
}
