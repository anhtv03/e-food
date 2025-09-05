import 'package:e_food/models/meal_statistic.dart';
import 'package:e_food/services/order_service.dart';
import 'package:e_food/services/token_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_event.dart';
import 'package:e_food/blocs/statistic_bloc/statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  StatisticBloc() : super(StatisticInitial()) {
    on<LoadStatisticEvent>(_onLoadStatistic);
  }

  Future<void> _onLoadStatistic(
    LoadStatisticEvent event,
    Emitter<StatisticState> emit,
  ) async {
    emit(StatisticLoading());

    try {
      await Future.delayed(Duration(milliseconds: 800));
      String token = await TokenService.getToken('user') as String;
      final statistics = await OrderService.getAllOrderByUserIdForMonthYear(
        token,
        event.month,
        event.year,
      );

      final totalAmount = (statistics['data'] as List<MealStatistic>)
          .fold<double>(0, (sum, meal) => sum + meal.totalPrice);

      emit(
        StatisticLoaded(
          mealStatistics: statistics['data'] as List<MealStatistic>,
          totalAmount: totalAmount,
        ),
      );
    } catch (e) {
      emit(StatisticError(message: e.toString()));
    }
  }
}
