part of 'new_game_page.dart';

mixin NewGamePageMixin on State<NewGameView> {
  late TextEditingController valueGameRuleController;
  GameRule gameRuleSelected = GameRule.normal;
  bool isShowError = false;
  final quantityPlayer = [2, 3, 4, 5];

  @override
  void initState() {
    super.initState();
    valueGameRuleController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    valueGameRuleController.dispose();
  }

  void onChangeChooseQuantityPlayer(int? value) {
    if (value != null) {
      context.read<NewGameBloc>().add(NewGameChangeQuantityPlayer(value));
    }
  }

  void onPressedSaveGameRule() {
    if ((gameRuleSelected != GameRule.normal) &&
        valueGameRuleController.text.isEmpty) {
      setState(() {
        isShowError = true;
      });
      return;
    }
    context.read<NewGameBloc>().add(NewGameSelectGameRule(gameRuleSelected));
    context
        .read<NewGameBloc>()
        .add(NewGameUpdateRuleValue(valueGameRuleController.text));
    Navigator.pop(context);
  }

  String getUnit(GameRule gameRule) {
    switch (gameRule) {
      case GameRule.limitGame:
        return 'games';
      case GameRule.limitScore:
        return 'points';
      case GameRule.normal:
        return '';
    }
  }

  String getTypeOfGameRule(GameRule gameRule) {
    switch (gameRule) {
      case GameRule.limitGame:
        return 'Max matches';
      case GameRule.limitScore:
        return 'Max score';
      default:
        return GameRule.normal.title;
    }
  }
}
