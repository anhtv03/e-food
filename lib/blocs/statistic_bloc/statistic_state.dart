import 'package:e_food/models/meal_statistic.dart';

abstract class StatisticState {}

class StatisticInitial extends StatisticState {}

class StatisticLoading extends StatisticState {}

class StatisticLoaded extends StatisticState {
  final List<MealStatistic> mealStatistics;
  final double totalAmount;

  StatisticLoaded({required this.mealStatistics, required this.totalAmount});
}

class StatisticError extends StatisticState {
  final String message;

  StatisticError({required this.message});
}
