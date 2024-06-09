part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();
  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

class HistoryLoadInProgress extends HistoryState {}

class HistoryLoadSuccess extends HistoryState {
  final List<ScoreBoard> games;

  const HistoryLoadSuccess(this.games);

  @override
  List<Object> get props => [games];
}

class HistoryLoadFailure extends HistoryState {}
