import 'package:e_food/models/history.dart';
import 'package:e_food/services/order_service.dart';
import 'package:e_food/services/token_service.dart';
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
      String token = await TokenService.getToken('user') as String;
      var orderHistory = await OrderService.getAllOrdersByUserId(token);

      emit(
        HistoryLoaded(orderHistory: orderHistory['data'] as List<OrderHistory>),
      );
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
        String token = await TokenService.getToken('user') as String;
        var orderHistory = await OrderService.getAllOrdersByUserId(token);

        emit(
          HistoryLoaded(
            orderHistory: orderHistory['data'] as List<OrderHistory>,
          ),
        );
      } catch (e) {
        final errorMessage = event.localizations?.failedRenewHistory;
        emit(HistoryError(message: errorMessage!));
      }
    } else {
      add(LoadHistoryEvent(localizations: event.localizations));
    }
  }
}
