import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:calculate_card_score/app/app_bloc_observer.dart';
import 'package:flutter/widgets.dart';

void bootstrap() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
  // runZonedGuarded(
  //   () => runApp(const App()),
  //   (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  // );
}
