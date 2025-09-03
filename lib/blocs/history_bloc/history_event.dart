import 'package:equatable/equatable.dart';
import 'package:e_food/l10n/app_localizations.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadHistoryEvent extends HistoryEvent {
  final AppLocalizations? localizations;

  const LoadHistoryEvent({this.localizations});

  @override
  List<Object?> get props => [localizations];
}

class RefreshHistoryEvent extends HistoryEvent {
  final AppLocalizations? localizations;

  const RefreshHistoryEvent({this.localizations});

  @override
  List<Object?> get props => [localizations];
}
