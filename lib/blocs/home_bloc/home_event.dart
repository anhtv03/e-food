import 'package:e_food/models/meal.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class LoadHomeEvent extends HomeEvent {
  const LoadHomeEvent();
}

class OrderMealEvent extends HomeEvent {
  final Meal meal;

  const OrderMealEvent({required this.meal});
}

class CancelMealEvent extends HomeEvent {
  final Meal meal;

  const CancelMealEvent({required this.meal});
}
