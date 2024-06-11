import 'package:score_card_master/data/models/score_board_model.dart';

abstract class BoardGameApi {
  const BoardGameApi();

  Future<int> addGame(ScoreBoard scoreBoard);

  Future<void> deleteGame(int id);

  Future<void> updateGame(int id, ScoreBoard scoreBoard);

  Future<List<dynamic>> getAllGames();
}
