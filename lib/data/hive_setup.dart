import 'package:hive_flutter/hive_flutter.dart';

import 'models/player_model.dart';
import 'models/round_model.dart';
import 'models/score_board_model.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(ScoreBoardAdapter())
    ..registerAdapter(RoundAdapter())
    ..registerAdapter(PlayerAdapter());
}
