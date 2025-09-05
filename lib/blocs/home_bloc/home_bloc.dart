import 'package:e_food/services/food_service.dart';
import 'package:e_food/services/order_service.dart';
import 'package:e_food/services/token_service.dart';
import 'package:e_food/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeEvent>(_onLoadHome);
    on<OrderMealEvent>(_onOrderMeal);
    on<CancelMealEvent>(_onCancelMeal);
  }

  Future<void> _onLoadHome(LoadHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    try {
      await Future.delayed(Duration(seconds: 1));
      String token = await TokenService.getToken('user') as String;
      var userResult = await UserService.getUser(token);
      var meals = await FoodService.getFoodItemsOnThisWeek(token);

      emit(HomeLoaded(meals: meals.data, userName: userResult.data.fullName));
    } catch (e) {
      final errorMessage = event.localizations?.cantCancel;
      emit(HomeError(message: errorMessage!));
    }
  }

  Future<void> _onOrderMeal(
    OrderMealEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      try {
        await Future.delayed(Duration(milliseconds: 500));
        String token = await TokenService.getToken('user') as String;
        await OrderService.createOrder(token, event.meal.id);

        final meals = await FoodService.getFoodItemsOnThisWeek(token);
        emit(currentState.copyWith(meals: meals.data));
      } catch (e) {
        final errorMessage = event.localizations?.cantCancel;
        emit(HomeError(message: errorMessage!));
      }
    }
  }

  Future<void> _onCancelMeal(
    CancelMealEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      try {
        await Future.delayed(Duration(milliseconds: 500));
        String token = await TokenService.getToken('user') as String;
        await OrderService.cancelOrder(token, event.meal.id);

        final meals = await FoodService.getFoodItemsOnThisWeek(token);
        emit(currentState.copyWith(meals: meals.data));
      } catch (e) {
        final errorMessage = event.localizations?.cantCancel;
        emit(HomeError(message: errorMessage!));
      }
    }
  }
}
