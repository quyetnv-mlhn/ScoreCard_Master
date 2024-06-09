import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:calculate_card_score/app/app.dart';
import 'package:calculate_card_score/app/app_bloc_observer.dart';
import 'package:calculate_card_score/data/hive_setup.dart';
import 'package:calculate_card_score/di/service_locator.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await setupHive();
  await setupLocator();
  runApp(const AppView());

  // bootstrap();
}
