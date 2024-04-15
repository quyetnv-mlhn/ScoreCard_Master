import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/core/constants/app_style.dart';
import 'package:calculate_card_score/data/models/player_model.dart';
import 'package:calculate_card_score/domain/repositories/player_repository.dart';
import 'package:calculate_card_score/features/game_detail/bloc/game_detail_bloc.dart';
import 'package:calculate_card_score/widgets/app_divider.dart';
import 'package:calculate_card_score/widgets/ordinal_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'game_detail_page_mixin.dart';

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

class GameDetailView extends StatefulWidget {
  const GameDetailView({super.key});

  @override
  State<GameDetailView> createState() => _GameDetailViewState();
}

class _GameDetailViewState extends State<GameDetailView>
    with GameDetailPageMixin {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: smallPadding),
        child: Column(
          children: [
            _buildNameAndTotalScore(),
            const SizedBox(height: smallPadding),
            const AppDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildNameAndTotalScore() {
    return Row(
      children: [
        ...[for (int i = 0; i < countPlayer; ++i) _buildOnePlayer(i)],
      ],
    );
  }

  Widget _buildOnePlayer(int i) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/hexagon.svg',
                  colorFilter: ColorFilter.mode(
                    Colors.yellow.shade700,
                    BlendMode.srcIn,
                  ),
                ),
                Center(
                  child: Text(
                    (i + 1).toString(),
                    style: AppStyle.boldTextStyle(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: smallPadding),
          AutoSizeText(
            players[i].name,
            style: AppStyle.boldTextStyle(size: 16),
          ),
          const SizedBox(height: smallPadding),
          OrdinalNumber(number: i + 1),
        ],
      ),
    );
  }
}
