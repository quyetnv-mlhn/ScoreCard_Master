part of 'game_detail_bloc.dart';

sealed class GameDetailEvent extends Equatable {
  const GameDetailEvent();

  @override
  List<Object> get props => [];
}

final class GameDetailAddRound extends GameDetailEvent {
  final Round round;

  const GameDetailAddRound(this.round);
}
