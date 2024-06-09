import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculate_card_score/data/models/player_model.dart';
import 'package:calculate_card_score/data/models/round_model.dart';
import 'package:calculate_card_score/data/models/score_board_model.dart';

part 'game_detail_event.dart';
part 'game_detail_state.dart';

class GameDetailBloc extends Bloc<GameDetailEvent, GameDetailState> {
  GameDetailBloc({required this.scoreBoard})
      : super(GameDetailState(scoreBoard: scoreBoard)) {
    on<GameDetailAddRound>(_onGameDetailAddRound);
    on<GameDetailChangeWinner>(_onGameDetailChangeWinner);
  }

  final ScoreBoard scoreBoard;

  // Handles the addition of a new round to the game details.
  // Updates the score and players based on the new round information.
  Future<void> _onGameDetailAddRound(
    GameDetailAddRound event,
    Emitter<GameDetailState> emit,
  ) async {
    final newRounds = event.rounds;
    final scoreBoard = state.scoreBoard;
    final currentScore = scoreBoard.currentScore;
    final players = scoreBoard.players;

    for (var newRound in newRounds) {
      newRound.players.asMap().forEach((index, player) {
        if (player.isWinner == true) {
          currentScore[index] = List.from(currentScore[index])
            ..map(
              (score) => score + (player.score ?? 0),
            );
        }
        players[index] = players[index].copyWith(
          score: (players[index].score ?? 0) + (player.score ?? 0),
        );
      });
    }

    final newScoreBoard = scoreBoard.copyWith(
      currentScore: currentScore,
      players: players,
    );
    emit(
      GameDetailState(
        scoreBoard: newScoreBoard,
        rounds: [...state.rounds, ...newRounds],
      ),
    );
  }

  Future<void> _onGameDetailChangeWinner(
    GameDetailChangeWinner event,
    Emitter<GameDetailState> emit,
  ) async {
    final players = state.scoreBoard.players;
    final newPlayers = players
        .map((player) =>
            player.copyWith(isWinner: player.name == event.player.name))
        .toList();
    emit(GameDetailState(
      scoreBoard: state.scoreBoard.copyWith(players: newPlayers),
      rounds: state.rounds,
    ));
  }
}
