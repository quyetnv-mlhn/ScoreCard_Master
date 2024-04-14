import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/features/new_game/widgets/info_player.dart';
import 'package:flutter/material.dart';

class ListPlayer extends StatelessWidget {
  const ListPlayer({super.key, required this.playerQuantity});

  final int playerQuantity;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: largePadding,
        mainAxisSpacing: smallPadding,
      ),
      itemCount: playerQuantity,
      itemBuilder: (BuildContext ctx, index) {
        return InfoPlayer(
          index: index,
          onChanged: (text) {},
        );
      },
    );
  }
}
