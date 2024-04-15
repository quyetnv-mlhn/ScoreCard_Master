import 'dart:ffi';

import 'package:calculate_card_score/core/constants/app_const.dart';
import 'package:calculate_card_score/core/constants/app_style.dart';
import 'package:calculate_card_score/data/models/player_model.dart';
import 'package:calculate_card_score/domain/repositories/player_repository.dart';
import 'package:calculate_card_score/features/game_detail/view/game_detail_page.dart';
import 'package:calculate_card_score/features/new_game/bloc/new_game_bloc.dart';
import 'package:calculate_card_score/widgets/action_button.dart';
import 'package:calculate_card_score/features/new_game/widgets/info_player.dart';
import 'package:calculate_card_score/widgets/ordinal_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_game_page_mixin.dart';

class NewGamePage extends StatelessWidget {
  const NewGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewGameBloc(),
      child: const SafeArea(child: NewGameView()),
    );
  }
}

class NewGameView extends StatefulWidget {
  const NewGameView({super.key});

  @override
  State<NewGameView> createState() => _NewGameViewState();
}

class _NewGameViewState extends State<NewGameView> with NewGamePageMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: primaryLightColor,
        appBar: AppBar(
          title: Text(
            'New game',
            style: AppStyle.boldTextStyle(color: primaryLightColor, size: 20.0),
          ),
          backgroundColor: primaryColor,
          automaticallyImplyLeading: true,
        ),
        body: BlocBuilder<NewGameBloc, NewGameState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: smallPadding,
                horizontal: largePadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildChooseQuantityPlayer(context, state, quantityPlayer),
                  _buildListPlayer(state.playerQuantity),
                  _buildGameRule(context, state),
                  const Spacer(),
                  _buildAllButtonStart(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChooseQuantityPlayer(
    BuildContext context,
    NewGameState state,
    List<int> quantityPlayer,
  ) {
    return Row(
      children: [
        const OrdinalNumber(number: 1),
        const SizedBox(width: smallPadding),
        Expanded(
          child: Text(
            'Select number of players',
            style: AppStyle.boldTextStyle(),
            maxLines: 1,
          ),
        ),
        const SizedBox(width: largePadding),
        SizedBox(
          width: 100,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: state.playerQuantity,
              items: quantityPlayer
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(
                          '$value players',
                          style: AppStyle.mediumTextStyle(),
                        ),
                      ))
                  .toList(),
              onChanged: onChangeChooseQuantityPlayer,
              isExpanded: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGameRule(BuildContext context, NewGameState state) {
    final gameRule = state.gameRule;
    final gameRuleValue = state.gameRuleValue;
    return Row(
      children: [
        const OrdinalNumber(number: 2),
        const SizedBox(width: smallPadding),
        Text(
          'Game rule',
          style: AppStyle.boldTextStyle(),
        ),
        const Spacer(),
        const SizedBox(width: largePadding),
        InkWell(
          onTap: () => _onChooseGameRule(context),
          child: Row(
            children: [
              Text(
                '${getTypeOfGameRule(gameRule)} ${gameRuleValue != '' ? ': $gameRuleValue ${getUnit(gameRule)}' : ''}',
                style: AppStyle.mediumTextStyle(),
              ),
              const SizedBox(width: smallPadding),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        )
      ],
    );
  }

  _onChooseGameRule(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return _buildDialogSelectGameRule(context);
      },
    );
  }

  BlocProvider<NewGameBloc> _buildDialogSelectGameRule(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<NewGameBloc>(context),
      child: BlocBuilder<NewGameBloc, NewGameState>(
        builder: (context, state) {
          return AlertDialog(
            scrollable: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            title: const Text(
              'Select game rule',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            titlePadding: const EdgeInsets.only(top: largePadding),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: StatefulBuilder(builder: (context, setState) {
                return Column(
                  children: [
                    _buildAllOptionGameRule(context, setState),
                    _buildAllActionButton(context, setState),
                  ],
                );
              }),
            ),
            contentPadding: const EdgeInsets.all(smallPadding),
          );
        },
      ),
    );
  }

  Widget _buildAllActionButton(
    BuildContext context,
    void Function(void Function()) setState,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowError)
          Text(
            ' Please fill the value',
            style: AppStyle.boldTextStyle(color: Colors.red),
          ),
        Row(
          children: [
            ActionButton(
              color: primaryColor,
              textColor: primaryLightColor,
              text: 'Save',
              onPressed: onPressedSaveGameRule,
            ),
            const SizedBox(width: smallPadding),
            ActionButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ],
    );
  }

  Row _buildAllOptionGameRule(
    BuildContext context,
    void Function(void Function()) setState,
  ) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionGameRule(context, GameRule.normal, setState),
              _buildOptionGameRule(context, GameRule.limitGame, setState),
              _buildOptionGameRule(context, GameRule.limitScore, setState),
            ],
          ),
        ),
        const SizedBox(width: smallPadding),
        if (gameRuleSelected != GameRule.normal)
          Flexible(
            flex: 1,
            child: Column(
              children: [
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: false,
                    decimal: false,
                  ),
                  controller: valueGameRuleController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: AppStyle.mediumTextStyle(size: 30),
                  onChanged: (value) {
                    if (value.isNotEmpty) setState(() => isShowError = false);
                  },
                ),
                Text(getUnit(gameRuleSelected),
                    style: AppStyle.boldTextStyle()),
              ],
            ),
          ),
      ],
    );
  }

  ListTile _buildOptionGameRule(
    BuildContext context,
    GameRule gameRule,
    void Function(void Function()) setState,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      dense: true,
      horizontalTitleGap: smallPadding,
      title: Text(
        gameRule.title,
        style: AppStyle.mediumTextStyle(),
      ),
      leading: Radio<GameRule>(
        value: gameRule,
        groupValue: gameRuleSelected,
        onChanged: (GameRule? value) {
          valueGameRuleController.clear();
          setState(() {
            gameRuleSelected = value ?? GameRule.normal;
          });
        },
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  _buildAllButtonStart(BuildContext context, NewGameState state) {
    return Row(
      children: [
        ActionButton(
          text: 'QUICK START',
          textColor: primaryLightColor,
          fontWeight: FontWeight.w800,
          color: primaryColor,
          iconData: Icons.add,
          onPressed: () => onQuickStartPressed(context, state),
        ),
        const SizedBox(width: smallPadding),
        ActionButton(
          text: 'START',
          iconData: Icons.play_arrow,
          fontWeight: FontWeight.w800,
          onPressed: () => onStartPressed(context, state),
        )
      ],
    );
  }

  Widget _buildListPlayer(int playerQuantity) {
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
          textEditingController: listNamePlayerControllers[index],
        );
      },
    );
  }
  
}
