import 'package:e_food/models/history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<LoadHistoryEvent>(_onLoadHistory);
    on<RefreshHistoryEvent>(_onRefreshHistory);
  }

  Future<void> _onLoadHistory(
    LoadHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading());

    try {
      await Future.delayed(Duration(seconds: 1));

      final orderHistory = [
        OrderHistory(
          id: '1',
          mealName: 'Cơm gà',
          serviceDate: DateTime(2025, 8, 4),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 8, 3, 9, 30),
          price: 25000,
        ),
        OrderHistory(
          id: '2',
          mealName: 'Miến xào',
          serviceDate: DateTime(2025, 8, 3),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 8, 2, 8, 45),
          price: 25000,
        ),
        OrderHistory(
          id: '3',
          mealName: 'Cơm trộn',
          serviceDate: DateTime(2025, 8, 1),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 7, 31, 9, 15),
          price: 25000,
        ),
        OrderHistory(
          id: '4',
          mealName: 'Mỳ xào',
          serviceDate: DateTime(2025, 7, 30),
          status: OrderStatus.cancelled,
          orderDate: DateTime(2025, 7, 29, 10, 30),
          price: 25000,
        ),
        OrderHistory(
          id: '5',
          mealName: 'Cơm gà',
          serviceDate: DateTime(2025, 8, 4),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 8, 3, 9, 30),
          price: 25000,
        ),
        OrderHistory(
          id: '6',
          mealName: 'Miến xào',
          serviceDate: DateTime(2025, 8, 3),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 8, 2, 8, 45),
          price: 25000,
        ),
        OrderHistory(
          id: '7',
          mealName: 'Cơm trộn',
          serviceDate: DateTime(2025, 8, 1),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 7, 31, 9, 15),
          price: 25000,
        ),
        OrderHistory(
          id: '4',
          mealName: 'Mỳ xào',
          serviceDate: DateTime(2025, 7, 30),
          status: OrderStatus.cancelled,
          orderDate: DateTime(2025, 7, 29, 10, 30),
          price: 25000,
        ),
        OrderHistory(
          id: '1',
          mealName: 'Cơm gà',
          serviceDate: DateTime(2025, 8, 4),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 8, 3, 9, 30),
          price: 25000,
        ),
        OrderHistory(
          id: '2',
          mealName: 'Miến xào',
          serviceDate: DateTime(2025, 8, 3),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 8, 2, 8, 45),
          price: 25000,
        ),
        OrderHistory(
          id: '3',
          mealName: 'Cơm trộn',
          serviceDate: DateTime(2025, 8, 1),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 7, 31, 9, 15),
          price: 25000,
        ),
        OrderHistory(
          id: '4',
          mealName: 'Mỳ xào',
          serviceDate: DateTime(2025, 7, 30),
          status: OrderStatus.cancelled,
          orderDate: DateTime(2025, 7, 29, 10, 30),
          price: 25000,
        ),
        OrderHistory(
          id: '1',
          mealName: 'Cơm gà',
          serviceDate: DateTime(2025, 8, 4),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 8, 3, 9, 30),
          price: 25000,
        ),
        OrderHistory(
          id: '2',
          mealName: 'Miến xào',
          serviceDate: DateTime(2025, 8, 3),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 8, 2, 8, 45),
          price: 25000,
        ),
        OrderHistory(
          id: '3',
          mealName: 'Cơm trộn',
          serviceDate: DateTime(2025, 8, 1),
          status: OrderStatus.completed,
          orderDate: DateTime(2025, 7, 31, 9, 15),
          price: 25000,
        ),
        OrderHistory(
          id: '4',
          mealName: 'Mỳ xào',
          serviceDate: DateTime(2025, 7, 30),
          status: OrderStatus.cancelled,
          orderDate: DateTime(2025, 7, 29, 10, 30),
          price: 25000,
        ),
      ];

      emit(HistoryLoaded(orderHistory: orderHistory));
    } catch (e) {
      final errorMessage = event.localizations?.loadFailedHistory;
      emit(HistoryError(message: errorMessage!));
    }
  }

  Future<void> _onRefreshHistory(
    RefreshHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    if (state is HistoryLoaded) {
      try {
        await Future.delayed(Duration(milliseconds: 500));

        final orderHistory = [
          OrderHistory(
            id: '1',
            mealName: 'Cơm gà',
            serviceDate: DateTime(2025, 8, 4),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 8, 3, 9, 30),
            price: 25000,
          ),
          OrderHistory(
            id: '2',
            mealName: 'Miến xào',
            serviceDate: DateTime(2025, 8, 3),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 8, 2, 8, 45),
            price: 25000,
          ),
          OrderHistory(
            id: '3',
            mealName: 'Cơm trộn',
            serviceDate: DateTime(2025, 8, 1),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 7, 31, 9, 15),
            price: 25000,
          ),
          OrderHistory(
            id: '4',
            mealName: 'Mỳ xào',
            serviceDate: DateTime(2025, 7, 30),
            status: OrderStatus.cancelled,
            orderDate: DateTime(2025, 7, 29, 10, 30),
            price: 25000,
          ),
          OrderHistory(
            id: '5',
            mealName: 'Cơm gà',
            serviceDate: DateTime(2025, 8, 4),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 8, 3, 9, 30),
            price: 25000,
          ),
          OrderHistory(
            id: '6',
            mealName: 'Miến xào',
            serviceDate: DateTime(2025, 8, 3),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 8, 2, 8, 45),
            price: 25000,
          ),
          OrderHistory(
            id: '7',
            mealName: 'Cơm trộn',
            serviceDate: DateTime(2025, 8, 1),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 7, 31, 9, 15),
            price: 25000,
          ),
          OrderHistory(
            id: '4',
            mealName: 'Mỳ xào',
            serviceDate: DateTime(2025, 7, 30),
            status: OrderStatus.cancelled,
            orderDate: DateTime(2025, 7, 29, 10, 30),
            price: 25000,
          ),
          OrderHistory(
            id: '1',
            mealName: 'Cơm gà',
            serviceDate: DateTime(2025, 8, 4),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 8, 3, 9, 30),
            price: 25000,
          ),
          OrderHistory(
            id: '2',
            mealName: 'Miến xào',
            serviceDate: DateTime(2025, 8, 3),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 8, 2, 8, 45),
            price: 25000,
          ),
          OrderHistory(
            id: '3',
            mealName: 'Cơm trộn',
            serviceDate: DateTime(2025, 8, 1),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 7, 31, 9, 15),
            price: 25000,
          ),
          OrderHistory(
            id: '4',
            mealName: 'Mỳ xào',
            serviceDate: DateTime(2025, 7, 30),
            status: OrderStatus.cancelled,
            orderDate: DateTime(2025, 7, 29, 10, 30),
            price: 25000,
          ),
          OrderHistory(
            id: '1',
            mealName: 'Cơm gà',
            serviceDate: DateTime(2025, 8, 4),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 8, 3, 9, 30),
            price: 25000,
          ),
          OrderHistory(
            id: '2',
            mealName: 'Miến xào',
            serviceDate: DateTime(2025, 8, 3),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 8, 2, 8, 45),
            price: 25000,
          ),
          OrderHistory(
            id: '3',
            mealName: 'Cơm trộn',
            serviceDate: DateTime(2025, 8, 1),
            status: OrderStatus.completed,
            orderDate: DateTime(2025, 7, 31, 9, 15),
            price: 25000,
          ),
          OrderHistory(
            id: '4',
            mealName: 'Mỳ xào',
            serviceDate: DateTime(2025, 7, 30),
            status: OrderStatus.cancelled,
            orderDate: DateTime(2025, 7, 29, 10, 30),
            price: 25000,
          ),
        ];

        emit(HistoryLoaded(orderHistory: orderHistory));
      } catch (e) {
        final errorMessage = event.localizations?.failedRenewHistory;
        emit(HistoryError(message: errorMessage!));
      }
    } else {
      add(LoadHistoryEvent(localizations: event.localizations));
    }
  }
}
