import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadHistoryEvent extends HistoryEvent {
  const LoadHistoryEvent();

  @override
  List<Object> get props => [];
}

class RefreshHistoryEvent extends HistoryEvent {
  const RefreshHistoryEvent();

  @override
  List<Object> get props => [];
}
