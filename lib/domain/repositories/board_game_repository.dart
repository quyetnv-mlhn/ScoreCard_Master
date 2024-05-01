import 'package:calculate_card_score/data/data_sources/board_game_api.dart';
import 'package:calculate_card_score/data/models/round_model.dart';
import 'package:calculate_card_score/data/models/score_board_model.dart';

class BoardGameRepository {
  final BoardGameApi _boardGameApi;

  BoardGameRepository(this._boardGameApi);

  Future<int> addGame(ScoreBoard scoreBoard) async {
    return await _boardGameApi.addGame(scoreBoard);
  }

  Future<void> deleteGame(int id) async {
    await _boardGameApi.deleteGame(id);
  }

  Future<void> addRound(int gameId, Round round) async {
    await _boardGameApi.addRound(gameId, round);
  }

  Future<void> deleteRound(int roundId) async {
    await _boardGameApi.deleteRound(roundId);
  }
}
