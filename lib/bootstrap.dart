import 'dart:developer';

import 'package:calculate_card_score/app/app_bloc_observer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
