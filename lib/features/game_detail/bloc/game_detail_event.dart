part of 'game_detail_bloc.dart';

sealed class GameDetailEvent extends Equatable {
  const GameDetailEvent();
}

final class GameDetailAddRound extends GameDetailEvent {
  final Round round;

  const GameDetailAddRound(this.round);

  @override
  List<Object?> get props => [round];
}

final class GameDetailChangeWinner extends GameDetailEvent {
  final Player player;
  

  const GameDetailChangeWinner(this.player);

  @override
  List<Object?> get props => [player];
}
