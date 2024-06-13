part of 'game_detail_bloc.dart';

sealed class GameDetailEvent extends Equatable {
  const GameDetailEvent();
}

class GameDetailLoadOldGame extends GameDetailEvent {
  final ScoreBoard scoreBoard;

  @override
  List<Object?> get props => [];

  const GameDetailLoadOldGame({
    required this.scoreBoard,
  });
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
