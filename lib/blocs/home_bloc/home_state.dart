import 'package:e_food/models/meal.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Meal> meals;
  final String userName;

  HomeLoaded({required this.meals, required this.userName});

  HomeLoaded copyWith({List<Meal>? meals, String? userName}) {
    return HomeLoaded(
      meals: meals ?? this.meals,
      userName: userName ?? this.userName,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
