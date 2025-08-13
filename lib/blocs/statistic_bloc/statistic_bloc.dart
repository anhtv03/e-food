import 'package:e_food/models/meal_statistic.dart';
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
      final statistics = _getSampleStatistics(event.month, event.year);
      double totalAmount = statistics.fold(0, (sum, meal) => sum + meal.price);

      emit(
        StatisticLoaded(mealStatistics: statistics, totalAmount: totalAmount),
      );
    } catch (e) {
      emit(StatisticError(message: e.toString()));
    }
  }

  List<MealStatistic> _getSampleStatistics(int month, int year) {
    final mealNames = [
      'Cơm gà',
      'Miến xào',
      'Cơm trộn',
      'Mỳ xào',
      'Phở bò',
      'Bún chả',
      'Cơm sườn',
      'Bánh mì',
      'Bún bò',
      'Cháo gà',
    ];

    final statistics = <MealStatistic>[];
    final mealCount = 10;

    for (int i = 0; i < mealCount; i++) {
      final day = (i + 1) * 3;
      final adjustedDay = day > 28 ? 28 - i : day;

      statistics.add(
        MealStatistic(
          mealName: mealNames[i % mealNames.length],
          price: 25000,
          serviceDate: DateTime(year, month, adjustedDay),
        ),
      );
    }

    statistics.sort((a, b) => b.serviceDate.compareTo(a.serviceDate));

    return statistics;
  }
}
