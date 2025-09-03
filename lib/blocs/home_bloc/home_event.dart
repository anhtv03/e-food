import 'package:e_food/models/meal.dart';
import 'package:e_food/l10n/app_localizations.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeEvent extends HomeEvent {
  final AppLocalizations? localizations;

  const LoadHomeEvent({this.localizations});

  @override
  List<Object?> get props => [localizations];
}

class OrderMealEvent extends HomeEvent {
  final Meal meal;
  final AppLocalizations? localizations;

  const OrderMealEvent({required this.meal, this.localizations});

  @override
  List<Object?> get props => [meal, localizations];
}

class CancelMealEvent extends HomeEvent {
  final Meal meal;
  final AppLocalizations? localizations;

  const CancelMealEvent({required this.meal, this.localizations});

  @override
  List<Object?> get props => [meal, localizations];
}
