import 'package:flutter/material.dart';

import '../core/constants/app_const.dart';
import '../features/new_game/view/new_game_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NewGamePage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: backGroundColor,
          primary: primaryColor,
        ),
      ),
    );
  }
}
