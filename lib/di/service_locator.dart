import 'package:get_it/get_it.dart';

import '../data/data_sources/local/local_board_game_api.dart';
import '../domain/repositories/board_game_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<BoardGameRepository>(
    BoardGameRepository(LocalBoardGameApi()),
  );
}
