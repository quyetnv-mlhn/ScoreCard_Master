import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/core/constants/app_style.dart';
import 'package:calculate_card_score/data/models/score_board_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.scoreBoard,
    this.onTap,
  });
  final ScoreBoard scoreBoard;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          leading: Column(
            children: [
              const Icon(Icons.bubble_chart_outlined),
              Text(
                DateFormat('HH:mm').format(scoreBoard.timestamp),
                style: AppStyle.boldTextStyle(),
              ),
            ],
          ),
          title: Row(
            children: scoreBoard.players
                .map((e) => Expanded(
                      child: Text(
                        e.name,
                        style: AppStyle.boldTextStyle(size: mediumFontSize),
                        textAlign: TextAlign.center,
                      ),
                    ))
                .toList(),
          ),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
