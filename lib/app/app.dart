import 'package:score_card_master/features/history/view/history_page.dart';
import 'package:flutter/material.dart';

import 'package:score_card_master/core/constants/app_const.dart';

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
      home: const HistoryPage(),
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
