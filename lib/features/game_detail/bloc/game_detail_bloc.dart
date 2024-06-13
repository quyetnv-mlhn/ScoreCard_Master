import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_card_master/data/data_sources/board_game_api/local/local_board_game_api.dart';
import 'package:score_card_master/data/models/player_model.dart';
import 'package:score_card_master/data/models/round_model.dart';
import 'package:score_card_master/data/models/score_board_model.dart';

part 'game_detail_event.dart';
part 'game_detail_state.dart';

class GameDetailBloc extends Bloc<GameDetailEvent, GameDetailState> {
  GameDetailBloc({
    required this.scoreBoard,
    required LocalBoardGameApi localBoardGameApi,
  })  : _localBoardGameApi = localBoardGameApi,
        super(GameDetailState(scoreBoard: scoreBoard)) {
    on<GameDetailLoadOldGame>(_onGameDetailLoadOldGame);
    on<GameDetailAddRound>(_onGameDetailAddRound);
    on<GameDetailChangeWinner>(_onGameDetailChangeWinner);
  }

  final ScoreBoard scoreBoard;
  final LocalBoardGameApi _localBoardGameApi;

  FutureOr<void> _onGameDetailLoadOldGame(
    GameDetailLoadOldGame event,
    Emitter<GameDetailState> emit,
  ) {
    final oldScoreBoard = event.scoreBoard;
    emit(GameDetailState(
      scoreBoard: oldScoreBoard,
      rounds: oldScoreBoard.rounds,
    ));
  }

  // Handles the addition of a new round to the game details.
  // Updates the score and players based on the new round information.
  Future<void> _onGameDetailAddRound(
    GameDetailAddRound event,
    Emitter<GameDetailState> emit,
  ) async {
    final newRound = event.round;
    final currentScore = List<List<int>>.from(
      state.scoreBoard.currentScore.map((scores) => List<int>.from(scores)),
    );
    final players = List<Player>.from(state.scoreBoard.players);

    for (var i = 0; i < newRound.players.length; i++) {
      final player = players[i];
      if (player.isWinner == true) {
        for (int j = 0; j < newRound.players.length; j++) {
          currentScore[i][j] += (newRound.players[j].score ?? 0);
          players[j] = players[j].copyWith(
            score: (newRound.players[j].score ?? 0) + (players[j].score ?? 0),
          );
        }
      }
    }

    final newScoreBoard = state.scoreBoard.copyWith(
      currentScore: currentScore,
      players: players,
      rounds: [...state.rounds, newRound],
    );

    await _localBoardGameApi.updateGame(state.scoreBoard.id, newScoreBoard);

    emit(
      GameDetailState(
        scoreBoard: newScoreBoard,
        rounds: [...state.rounds, newRound],
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
