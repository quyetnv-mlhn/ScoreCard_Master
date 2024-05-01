import 'package:calculate_card_score/app/app.dart';
import 'package:calculate_card_score/app/app_bloc_observer.dart';
import 'package:calculate_card_score/data/models/score_board_model.dart';
import 'package:calculate_card_score/data/models/player_model.dart';
import 'package:calculate_card_score/data/models/round_model.dart';
import 'package:calculate_card_score/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  setupLocator();
  await Hive.initFlutter();
  Hive.registerAdapter(ScoreBoardAdapter());
  Hive.registerAdapter(RoundAdapter());
  Hive.registerAdapter(PlayerAdapter());
  runApp(const AppView());

  // bootstrap();
}
