import 'package:e_food/models/history.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<OrderHistory> orderHistory;

  HistoryLoaded({required this.orderHistory});

  HistoryLoaded copyWith({List<OrderHistory>? orderHistory}) {
    return HistoryLoaded(orderHistory: orderHistory ?? this.orderHistory);
  }
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError({required this.message});
}
