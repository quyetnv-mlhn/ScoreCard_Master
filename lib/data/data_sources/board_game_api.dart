import 'package:calculate_card_score/data/models/round_model.dart';
import 'package:calculate_card_score/data/models/score_board_model.dart';

abstract class BoardGameApi {
  const BoardGameApi();

  Future<int> addGame(ScoreBoard scoreBoard);

  Future<void> deleteGame(int id);

  Future<void> addRound(int gameId, Round round);

  Future<void> deleteRound(int roundId);

  Future<List<dynamic>> getAllGames();
}
