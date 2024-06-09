part of 'game_detail_bloc.dart';

sealed class GameDetailEvent extends Equatable {
  const GameDetailEvent();
}

final class GameDetailAddRound extends GameDetailEvent {
  const GameDetailAddRound(this.rounds);
  final List<Round> rounds;

  @override
  List<Object?> get props => [rounds];
}

final class GameDetailChangeWinner extends GameDetailEvent {
  const GameDetailChangeWinner(this.player);
  final Player player;

  @override
  List<Object?> get props => [player];
}
