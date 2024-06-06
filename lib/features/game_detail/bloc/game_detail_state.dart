part of 'game_detail_bloc.dart';

class GameDetailState extends Equatable {
  const GameDetailState({
    required this.scoreBoard,
    this.rounds = const <Round>[],
  });
  final List<Round> rounds;
  final ScoreBoard scoreBoard;

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
