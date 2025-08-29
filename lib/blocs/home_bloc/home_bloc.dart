import 'package:e_food/l10n/app_localizations.dart';
import 'package:e_food/models/meal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BuildContext context;

  HomeBloc({required this.context}) : super(HomeInitial()) {
    on<LoadHomeEvent>(_onLoadHome);
    on<OrderMealEvent>(_onOrderMeal);
    on<CancelMealEvent>(_onCancelMeal);
  }

  Future<void> _onLoadHome(LoadHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final localizations = AppLocalizations.of(context);

    try {
      await Future.delayed(Duration(seconds: 1));

      final meals = [
        Meal(
          id: '1',
          name: 'Cơm gà',
          imageUrl: 'assets/images/com_ga.jpg',
          price: 25000,
          serviceDate: DateTime(2025, 8, 11),
          isOrdered: true,
        ),
        Meal(
          id: '2',
          name: 'Phở gà',
          imageUrl: 'assets/images/pho_ga.jpg',
          price: 25000,
          serviceDate: DateTime(2025, 8, 12),
          isOrdered: true,
        ),
        Meal(
          id: '3',
          name: 'Mỳ cay',
          imageUrl: 'assets/images/my_cay.jpg',
          price: 25000,
          serviceDate: DateTime(2025, 8, 13),
          isOrdered: false,
        ),
        Meal(
          id: '4',
          name: 'Cơm rang',
          imageUrl: 'assets/images/com_rang.jpg',
          price: 25000,
          serviceDate: DateTime(2025, 8, 14),
          isOrdered: false,
        ),
        Meal(
          id: '5',
          name: 'Cơm trộn',
          imageUrl: 'assets/images/com_tron.jpg',
          price: 25000,
          serviceDate: DateTime(2025, 8, 15),
          isOrdered: false,
        ),
        Meal(
          id: '1',
          name: 'Cơm gà',
          imageUrl: 'assets/images/com_ga.jpg',
          price: 25000,
          serviceDate: DateTime(2025, 8, 16),
          isOrdered: false,
        ),
        Meal(
          id: '2',
          name: 'Phở gà',
          imageUrl: 'assets/images/pho_ga.jpg',
          price: 25000,
          serviceDate: DateTime(2025, 8, 17),
          isOrdered: false,
        ),
        Meal(
          id: '3',
          name: 'Mỳ cay',
          imageUrl: 'assets/images/my_cay.jpg',
          price: 25000,
          serviceDate: DateTime(2025, 8, 18),
          isOrdered: false,
        ),
        Meal(
          id: '4',
          name: 'Cơm rang',
          imageUrl: 'assets/images/com_rang.jpg',
          price: 25000,
          serviceDate: DateTime(2025, 8, 18),
          isOrdered: true,
        ),
        Meal(
          id: '5',
          name: 'Cơm trộn',
          imageUrl: 'assets/images/com_tron.jpg',
          price: 25000,
          serviceDate: DateTime(2025, 8, 20),
          isOrdered: true,
        ),
      ];

      emit(HomeLoaded(meals: meals, userName: 'Lê Văn Thành'));
    } catch (e) {
      emit(HomeError(message: localizations.noData));
    }
  }

  Future<void> _onOrderMeal(
    OrderMealEvent event,
    Emitter<HomeState> emit,
  ) async {
    final localizations = AppLocalizations.of(context);
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      try {
        await Future.delayed(Duration(milliseconds: 500));

        final updatedMeals =
            currentState.meals.map((meal) {
              if (meal.id == event.meal.id) {
                return meal.copyWith(isOrdered: true);
              }
              return meal;
            }).toList();

        emit(currentState.copyWith(meals: updatedMeals));
      } catch (e) {
        emit(HomeError(message: localizations.cantOrder));
      }
    }
  }

  Future<void> _onCancelMeal(
    CancelMealEvent event,
    Emitter<HomeState> emit,
  ) async {
    final localizations = AppLocalizations.of(context);
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      try {
        await Future.delayed(Duration(milliseconds: 500));

        final updatedMeals =
            currentState.meals.map((meal) {
              if (meal.id == event.meal.id) {
                return meal.copyWith(isOrdered: false);
              }
              return meal;
            }).toList();

        emit(currentState.copyWith(meals: updatedMeals));
      } catch (e) {
        emit(HomeError(message: localizations.cantCancel));
      }
    }
  }
}
