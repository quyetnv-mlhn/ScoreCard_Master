import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/core/constants/app_style.dart';
import 'package:calculate_card_score/data/models/player_model.dart';
import 'package:calculate_card_score/data/models/round_model.dart';
import 'package:calculate_card_score/domain/repositories/player_repository.dart';
import 'package:calculate_card_score/features/game_detail/bloc/game_detail_bloc.dart';
import 'package:calculate_card_score/widgets/action_button.dart';
import 'package:calculate_card_score/widgets/app_divider.dart';
import 'package:calculate_card_score/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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
        onPressed: () => _onAddRoundPressed(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<GameDetailBloc, GameDetailState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: smallPadding),
            child: Column(
              children: [
                _buildNameAndTotalScore(),
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
          FittedBox(
            child: Text(
              players[i].name,
              style: AppStyle.boldTextStyle(size: 16),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: smallPadding),
          CircleAvatarCustom(number: i + 1),
        ],
      ),
    );
  }

  void _onAddRoundPressed(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
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
                (index) => _buildInputScore(index),
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
        actionsPadding:
            const EdgeInsets.only(top: 25, right: 15, left: 15, bottom: 15),
      ),
    );
  }

  Widget _buildInputScore(int index) {
    final Player player = players[index];
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildName(player.name),
            _buildScore(inputScoreEditingControllers[index]),
          ],
        ),
      ],
    );
  }

  Widget _buildName(String name) {
    return Expanded(
      child: Row(
        children: [
          CircleAvatarCustom(
            character: name.substring(0, 1),
            backgroundColor: primaryColor,
          ),
          const SizedBox(width: smallPadding),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                maxLines: 1,
                style: AppStyle.mediumTextStyle(size: mediumFontSize),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScore(TextEditingController controller) {
    return Expanded(
      child: Row(
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
                    hintStyle: AppStyle.mediumTextStyle(
                      color: textColor,
                      size: largeFontSize,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
    return ListView.builder(
        itemCount: state.rounds.length,
        itemBuilder: (context, index) {
          final round = state.rounds[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.only(bottom: 5),
                    color: Colors.grey,
                    child: Text('${index + 1}'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.only(bottom: 5),
                    color: Colors.grey,
                    child: Text(DateFormat.Hm().format(round.createdAt)),
                  )
                ],
              ),
              Row(
                children: [
                  ...List.generate(
                    countPlayer,
                    (index) => Expanded(
                      child: Center(
                        child: Text(
                          '${round.players[index].scores?[index] ?? 0}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(width: paddingMain),
                ],
              ),
              const SizedBox(height: 5),
              if (noteController.text.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(noteController.text),
                    const Icon(Icons.format_quote),
                  ],
                ),
              const AppDivider(),
            ],
          );
        });
  }
}
