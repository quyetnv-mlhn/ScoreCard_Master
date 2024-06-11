import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_card_master/app/app.dart';
import 'package:score_card_master/app/app_bloc_observer.dart';
import 'package:score_card_master/data/hive_setup.dart';
import 'package:score_card_master/di/service_locator.dart';
import 'package:score_card_master/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = const AppBlocObserver();
  await setupHive();
  await setupLocator();
  runApp(const AppView());

  // bootstrap();
}
