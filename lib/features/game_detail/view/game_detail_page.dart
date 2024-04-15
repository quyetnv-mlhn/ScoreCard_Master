import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/core/constants/app_style.dart';
import 'package:calculate_card_score/features/game_detail/bloc/game_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameDetailPage extends StatelessWidget {
  const GameDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameDetailBloc(),
      child: const SafeArea(child: GameDetailView()),
    );
  }
}

class GameDetailView extends StatelessWidget {
  const GameDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Game Detail',
          style: AppStyle.boldTextStyle(color: primaryLightColor, size: 20.0),
        ),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: primaryLightColor),
      ),
    );
  }
}
