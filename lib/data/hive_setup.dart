import 'package:hive_flutter/hive_flutter.dart';

import 'package:score_card_master/data/models/player_model.dart';
import 'package:score_card_master/data/models/round_model.dart';
import 'package:score_card_master/data/models/score_board_model.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(ScoreBoardAdapter())
    ..registerAdapter(RoundAdapter())
    ..registerAdapter(PlayerAdapter());
}
