import 'package:score_card_master/data/data_sources/board_game_api/board_game_api.dart';
import 'package:score_card_master/data/models/score_board_model.dart';
import 'package:hive/hive.dart';

class LocalBoardGameApi implements BoardGameApi {
  static const String boardGameBoxName = 'boardGameBox';
  static const String roundBoxName = 'roundBox';

  late Box<ScoreBoard> boardGameBox;

  Future<void> initialize() async {
    boardGameBox = await Hive.openBox(boardGameBoxName);
  }

  @override
  Future<int> addGame(ScoreBoard scoreBoard) async {
    return boardGameBox.add(scoreBoard);
  }

  @override
  Future<void> deleteGame(int gameId) async {
    await boardGameBox.delete(gameId);
  }

  @override
  Future<void> updateGame(int gameId, ScoreBoard scoreBoard) async {
    await boardGameBox.put(gameId, scoreBoard);
  }

  @override
  Future<List<dynamic>> getAllGames() async {
    return boardGameBox.values.toList();
  }
}
