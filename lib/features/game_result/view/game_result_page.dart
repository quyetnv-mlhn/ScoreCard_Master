import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/core/constants/app_style.dart';
import 'package:calculate_card_score/data/models/player_model.dart';
import 'package:calculate_card_score/widgets/general_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:calculate_card_score/data/models/score_board_model.dart';
import 'package:calculate_card_score/data/models/round_model.dart';
import 'package:calculate_card_score/widgets/custom_card.dart';

class GameResultPage extends StatelessWidget {
  final ScoreBoard scoreBoard;
  final List<Round> rounds;

  const GameResultPage({
    super.key,
    required this.scoreBoard,
    required this.rounds,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: 'Game Result'),
      body: _buildBody(context, scoreBoard, rounds),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ScoreBoard scoreBoard,
    List<Round> rounds,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: smallPadding,
        horizontal: largePadding,
      ),
      child: ListView(
        children: scoreBoard.players.map((player) {
          return CustomCard(
            title: "Results for ${player.name}",
            content: _buildPlayerResults(context, scoreBoard, player),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPlayerResults(
    BuildContext context,
    ScoreBoard scoreBoard,
    Player player,
  ) {
    if (scoreBoard.currentScore == null) {
      return const Center(child: Text("Error: currentScore is null"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: scoreBoard.players
          .where((opponent) => opponent.name != player.name)
          .map((opponent) {
        final scoreDifference =
            scoreBoard.currentScore![scoreBoard.players.indexOf(player)]
                    [scoreBoard.players.indexOf(opponent)] -
                scoreBoard.currentScore![scoreBoard.players.indexOf(opponent)]
                    [scoreBoard.players.indexOf(player)];

        if (scoreDifference > 0) {
          return Text(
            "${player.name} won against ${opponent.name}: $scoreDifference",
            style: AppStyle.mediumTextStyle(),
          );
        } else if (scoreDifference < 0) {
          return Text(
            "${opponent.name} won against ${player.name}: ${scoreDifference.abs()}",
            style: AppStyle.mediumTextStyle(),
          );
        } else {
          return Text(
            "${player.name} drew with ${opponent.name}",
            style: AppStyle.mediumTextStyle(),
          );
        }
      }).toList(),
    );
  }
}
