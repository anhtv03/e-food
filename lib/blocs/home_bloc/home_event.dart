import 'package:e_food/models/meal.dart';

abstract class HomeEvent {}

class LoadHomeEvent extends HomeEvent {}

class OrderMealEvent extends HomeEvent {
  final Meal meal;

  OrderMealEvent({required this.meal});
}

class CancelMealEvent extends HomeEvent {
  final Meal meal;

  CancelMealEvent({required this.meal});
}
