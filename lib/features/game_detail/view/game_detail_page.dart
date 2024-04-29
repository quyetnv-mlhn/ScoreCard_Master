import 'package:calculate_card_score/data/models/score_board_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/core/constants/app_style.dart';
import 'package:calculate_card_score/data/models/player_model.dart';
import 'package:calculate_card_score/data/models/round_model.dart';
import 'package:calculate_card_score/features/game_detail/bloc/game_detail_bloc.dart';
import 'package:calculate_card_score/widgets/action_button.dart';
import 'package:calculate_card_score/widgets/app_divider.dart';
import 'package:calculate_card_score/widgets/circle_avatar.dart';

part 'game_detail_page_mixin.dart';

class GameDetailPage extends StatelessWidget {
  final ScoreBoard scoreBoard;
  const GameDetailPage({
    super.key,
    required this.scoreBoard,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameDetailBloc(scoreBoard: scoreBoard),
      child: SafeArea(
        child: GameDetailView(scoreBoard: scoreBoard),
      ),
    );
  }
}

class GameDetailView extends StatefulWidget {
  final ScoreBoard scoreBoard;

  const GameDetailView({
    super.key,
    required this.scoreBoard,
  });

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
        onPressed: () => _showDialogInputScore(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<GameDetailBloc, GameDetailState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: smallPadding),
            child: Column(
              children: [
                _buildNameAndTotalScore(state),
                const SizedBox(height: smallPadding),
                const AppDivider(),
                Expanded(child: _buildAllRound(state)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNameAndTotalScore(GameDetailState state) {
    return Row(
      children: List.generate(
        countPlayer,
        (index) => Expanded(
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
                      colorFilter: const ColorFilter.mode(
                        primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Center(
                      child: Text(
                        (state.scoreBoard.players[index].score ?? 0).toString(),
                        style: AppStyle.boldTextStyle(
                          color: textColor,
                          size: largeFontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: smallPadding),
              FittedBox(
                child: Text(
                  scoreBoard.players[index].name,
                  style: AppStyle.boldTextStyle(size: largeFontSize),
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: smallPadding),
              CircleAvatarCustom(number: index + 1),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialogInputScore(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocProvider.value(
          value: BlocProvider.of<GameDetailBloc>(context),
          child: BlocBuilder<GameDetailBloc, GameDetailState>(
            builder: (context, state) {
              return AlertDialog(
                scrollable: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                title: Text(
                  'Enter score for players',
                  style: AppStyle.boldTextStyle(size: 20),
                  textAlign: TextAlign.center,
                ),
                titlePadding: const EdgeInsets.symmetric(vertical: 15.0),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(
                        countPlayer,
                        (index) => _buildInputScore(index, state),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: noteController,
                          style: AppStyle.mediumTextStyle(),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            hintText: 'Enter your comment here',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                actions: [_buildActionButton()],
                actionsPadding: const EdgeInsets.only(
                    top: 25, right: 15, left: 15, bottom: 15),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInputScore(
    int index,
    GameDetailState state,
  ) {
    final Player player = state.scoreBoard.players[index];

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildName(player.name),
          _buildScore(inputScoreEditingControllers[index], player.name),
        ],
      ),
      leading: Radio(
        activeColor: primaryColor,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: player.name,
        groupValue: groupValueChooseWinner,
        onChanged: (String? value) =>
            _onChangeGroupValueChooseWinner(value, state),
      ),
    );
  }

  Widget _buildName(String name) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          name,
          maxLines: 1,
          style: AppStyle.mediumTextStyle(size: largeFontSize),
        ),
      ),
    );
  }

  Widget _buildScore(TextEditingController controller, String playerName) {
    return Expanded(
      child: groupValueChooseWinner == playerName
          ? Center(
              child: SvgPicture.asset('assets/images/crown.svg',
                  width: primaryFontSize * 2, height: primaryFontSize * 2),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatarCustom(
                  icon: Icons.remove,
                  onTap: () => _onSubtractPointPressed(controller),
                  backgroundColor: primaryColor,
                  radius: 15,
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: AppStyle.mediumTextStyle(size: largeFontSize),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          hintText: '0',
                          hintStyle:
                              AppStyle.mediumTextStyle(size: largeFontSize),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                CircleAvatarCustom(
                  icon: Icons.add,
                  onTap: () => _onAddPointPressed(controller),
                  backgroundColor: primaryColor,
                  radius: 15,
                ),
              ],
            ),
    );
  }

  Widget _buildActionButton() {
    return Row(
      children: [
        ActionButton(
          text: "CANCEL",
          iconData: Icons.close,
          onPressed: _onCancelInputScore,
        ),
        const SizedBox(width: 10),
        ActionButton(
          text: 'SAVE',
          iconData: Icons.save,
          textColor: primaryLightColor,
          color: primaryColor,
          onPressed: _onSaveInputScore,
        ),
      ],
    );
  }

  Widget _buildAllRound(GameDetailState state) {
    final rounds = List.of(state.rounds);
    final length = rounds.length;

    return ListView.builder(
      itemCount: length,
      itemBuilder: (context, index) {
        final reverseIndex = length - index - 1;
        final round = rounds[reverseIndex];
        return Container(
          color: reverseIndex % 2 == 0 ? backGroundColor : primaryLightColor,
          child: Column(
            children: [
              _buildOrdinalNumberAndTime(reverseIndex, round.createdAt),
              const SizedBox(height: smallPadding),
              _buildScoreOfRound(round),
              _buildNoteOfRound(round.note),
              const AppDivider(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNoteOfRound(String? note) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          note ?? '',
          style: AppStyle.mediumTextStyle(size: mediumFontSize),
        ),
        if (note != '') const Icon(Icons.format_quote),
      ],
    );
  }

  Widget _buildScoreOfRound(Round round) {
    return Row(
      children: [
        ...List.generate(
          countPlayer,
          (index) => Expanded(
            child: Center(
              child: Text(
                '${round.players[index].score ?? 0}',
                style: AppStyle.boldTextStyle(size: largeFontSize),
              ),
            ),
          ),
        ),
        // const SizedBox(width: paddingMain),
      ],
    );
  }

  Row _buildOrdinalNumberAndTime(int index, DateTime createdAt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: smallPadding),
          color: primaryColor,
          child: Text(
            '${index + 1}',
            style: AppStyle.boldTextStyle(color: textColor),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: smallPadding),
          color: primaryColor,
          child: Text(
            DateFormat.Hm().format(createdAt),
            style: AppStyle.boldTextStyle(color: textColor),
          ),
        )
      ],
    );
  }
}
