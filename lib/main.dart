import 'package:calculate_card_score/app/app.dart';
import 'package:calculate_card_score/app/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  runApp(const AppView());

  // bootstrap();
}
