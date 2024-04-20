part of 'game_detail_bloc.dart';

abstract class GameDetailState extends Equatable {
  const GameDetailState({required this.rounds});

  final List<Round> rounds;

  @override
  List<Object?> get props => [rounds];
}

class GameDetailInitial extends GameDetailState {
  const GameDetailInitial({required super.rounds});
}

class GameDetailAddedRound extends GameDetailState {
  const GameDetailAddedRound({required super.rounds});
}
