import 'package:calculate_card_score/data/data_sources/local/local_board_game_api.dart';
import 'package:calculate_card_score/domain/repositories/board_game_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<BoardGameRepository>(
    BoardGameRepository(LocalBoardGameApi()),
  );
}
