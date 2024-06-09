import 'package:calculate_card_score/data/data_sources/board_game_api/local/local_board_game_api.dart';
import 'package:calculate_card_score/domain/repositories/board_game_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final localBoardGameApi = LocalBoardGameApi();
  await localBoardGameApi.initialize();

  getIt.registerSingleton<LocalBoardGameApi>(localBoardGameApi);
  getIt.registerSingleton<BoardGameRepository>(BoardGameRepository(
    getIt<LocalBoardGameApi>(),
  ));
}
