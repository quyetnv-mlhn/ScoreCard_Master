import 'package:flutter/material.dart';

import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/core/constants/app_style.dart';
import 'package:calculate_card_score/data/models/player_model.dart';
import 'package:calculate_card_score/data/models/round_model.dart';
import 'package:calculate_card_score/data/models/score_board_model.dart';
import 'package:calculate_card_score/widgets/general_app_bar.dart';

class GameResultPage extends StatelessWidget {
  const GameResultPage({
    required this.scoreBoard,
    required this.rounds,
    super.key,
  });

  final ScoreBoard scoreBoard;
  final List<Round> rounds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: 'Game Result'),
      body: ListView.builder(
        itemCount: scoreBoard.players.length,
        itemBuilder: (context, index) {
          return _buildPlayerCard(context, scoreBoard.players[index]);
        },
      ),
    );
  }

  Widget _buildPlayerCard(BuildContext context, Player player) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              player.name,
              style: AppStyle.boldTextStyle(size: largeFontSize),
            ),
            const SizedBox(height: 8),
            ..._buildPlayerResults(context, player),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPlayerResults(BuildContext context, Player player) {
    return scoreBoard.players.map((opponent) {
      if (opponent.name != player.name) {
        final playerIndex = scoreBoard.players.indexOf(player);
        final opponentIndex = scoreBoard.players.indexOf(opponent);
        final scoreDifference = scoreBoard.currentScore[playerIndex]
                [opponentIndex] -
            scoreBoard.currentScore[opponentIndex][playerIndex];

        String resultText;
        IconData icon;

        if (scoreDifference > 0) {
          resultText =
              '${player.name} won against ${opponent.name}: $scoreDifference';
          icon = Icons.arrow_upward;
        } else if (scoreDifference < 0) {
          resultText =
              '${opponent.name} won against ${player.name}: ${scoreDifference.abs()}';
          icon = Icons.arrow_downward;
        } else {
          resultText = '${player.name} drew with ${opponent.name}';
          icon = Icons.horizontal_rule;
        }

        return ListTile(
          visualDensity: VisualDensity.compact,
          contentPadding: EdgeInsets.zero,
          dense: true,
          leading: Icon(icon, size: largeFontSize),
          title: Text(resultText, style: AppStyle.boldTextStyle()),
        );
      } else {
        return Container();
      }
    }).toList();
  }
}
