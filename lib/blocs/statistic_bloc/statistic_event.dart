abstract class StatisticEvent {}

class LoadStatisticEvent extends StatisticEvent {
  final int month;
  final int year;

  LoadStatisticEvent({required this.month, required this.year});
}
