import 'package:hive/hive.dart';

import '../../models/round_model.dart';
import '../../models/score_board_model.dart';
import '../board_game_api.dart';

class LocalBoardGameApi implements BoardGameApi {
  static const String boardGameBoxName = 'boardGameBox';
  static const String roundBoxName = 'roundBox';

  @override
  Future<int> addGame(ScoreBoard scoreBoard) async {
    final boardGameBox = await Hive.openBox(boardGameBoxName);
    return boardGameBox.add(scoreBoard);
  }

  @override
  Future<void> deleteGame(int gameId) async {
    final boardGameBox = await Hive.openBox(boardGameBoxName);
    await boardGameBox.delete(gameId);
  }

  @override
  Future<void> addRound(int gameId, Round round) async {
    final roundBox = await Hive.openBox(roundBoxName);
    await roundBox.add(round);
  }

  @override
  Future<void> deleteRound(int roundId) async {
    final roundBox = await Hive.openBox(roundBoxName);
    await roundBox.delete(roundId);
  }

  @override
  Future<List<dynamic>> getAllGames() async {
    final boardGameBox = await Hive.openBox(boardGameBoxName);
    return boardGameBox.values.toList();
  }
}
