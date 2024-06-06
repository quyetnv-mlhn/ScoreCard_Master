part of 'game_detail_bloc.dart';

sealed class GameDetailEvent extends Equatable {
  const GameDetailEvent();
}

final class GameDetailAddRound extends GameDetailEvent {
  const GameDetailAddRound(this.round);
  final Round round;

  @override
  List<Object?> get props => [round];
}

final class GameDetailChangeWinner extends GameDetailEvent {
  const GameDetailChangeWinner(this.player);
  final Player player;

  @override
  List<Object?> get props => [player];
}
