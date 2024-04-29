part of 'game_detail_bloc.dart';

class GameDetailState extends Equatable {
  final List<Round> rounds;
  final ScoreBoard scoreBoard;

  const GameDetailState({
    this.rounds = const <Round>[],
    required this.scoreBoard,
  });

  @override
  List<Object> get props => [rounds, scoreBoard];

  GameDetailState copyWith({
    List<Round>? rounds,
    ScoreBoard? scoreBoard,
  }) {
    return GameDetailState(
      rounds: rounds ?? this.rounds,
      scoreBoard: scoreBoard ?? this.scoreBoard,
    );
  }
}
