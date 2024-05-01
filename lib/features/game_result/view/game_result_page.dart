
import 'package:calculate_card_score/features/game_result/bloc/game_result_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameResultPage extends StatelessWidget {
  const GameResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameResultBloc(),
      child: const GameResultView(),
    );
  }
}

class GameResultView extends StatelessWidget {
  const GameResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
