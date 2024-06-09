import 'package:hive_flutter/hive_flutter.dart';

import 'package:calculate_card_score/data/models/player_model.dart';
import 'package:calculate_card_score/data/models/round_model.dart';
import 'package:calculate_card_score/data/models/score_board_model.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(ScoreBoardAdapter())
    ..registerAdapter(RoundAdapter())
    ..registerAdapter(PlayerAdapter());
}
