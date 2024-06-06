import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';
import 'data/hive_setup.dart';
import 'di/service_locator.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  setupLocator();
  await setupHive();
  runApp(const AppView());

  // bootstrap();
}
