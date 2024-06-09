import 'package:calculate_card_score/data/data_sources/board_game_api/board_game_api.dart';
import 'package:calculate_card_score/data/models/score_board_model.dart';

class BoardGameRepository {
  BoardGameRepository(this._boardGameApi);
  final BoardGameApi _boardGameApi;

  Future<int> addGame(ScoreBoard scoreBoard) async {
    return _boardGameApi.addGame(scoreBoard);
  }

  Future<void> deleteGame(int id) async {
    await _boardGameApi.deleteGame(id);
  }

  Future<void> updateGame(ScoreBoard scoreBoard) async {
    await _boardGameApi.updateGame(scoreBoard.id, scoreBoard);
  }

  Future<List<dynamic>> getAllGames() async {
    return _boardGameApi.getAllGames();
  }
}
