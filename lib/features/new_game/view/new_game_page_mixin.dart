part of 'new_game_page.dart';

mixin NewGamePageMixin on State<NewGameView> {
  late TextEditingController valueGameRuleController;
  GameRule gameRuleSelected = GameRule.normal;
  bool isShowError = false;
  final quantityPlayer = [2, 3, 4, 5];
  List<TextEditingController> listNamePlayerControllers = [];
  final PlayerRepository playerRepository = PlayerRepository();

  @override
  void initState() {
    super.initState();
    valueGameRuleController = TextEditingController();
    for (int i = 0; i < 5; ++i) {
      listNamePlayerControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    super.dispose();
    valueGameRuleController.dispose();
    for (var nameController in listNamePlayerControllers) {
      nameController.dispose();
    }
  }

  void _onChangeChooseQuantityPlayer(int? value) {
    if (value != null) {
      context.read<NewGameBloc>().add(NewGameChangeQuantityPlayer(value));
    }
  }

  void _onPressedSaveGameRule(void Function(void Function()) setState) {
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

  void _onStartPressed(BuildContext context, NewGameState state) {
    List<String> nameList = [];
    for (int i = 0; i < state.playerQuantity; ++i) {
      nameList.add(listNamePlayerControllers[i].text);
    }
    final error = _validateNameList(nameList);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }
    for (int i = 0; i < state.playerQuantity; ++i) {
      playerRepository
          .addPlayer(Player(name: listNamePlayerControllers[i].text));
    }
    for (var player in playerRepository.listPlayer) {
      print(player.toJson());
    }
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const GameDetailPage()));
  }

  void _onQuickStartPressed(BuildContext context, NewGameState state) {
    for (int i = 0; i < state.playerQuantity; ++i) {
      playerRepository.addPlayer(
          Player(name: String.fromCharCode(('A'.codeUnitAt(0) + i))));
    }
    for (var player in playerRepository.listPlayer) {
      print(player.toJson());
    }
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const GameDetailPage()));
  }

  String? _validateNameList(List<String> nameList) {
    if (nameList.isEmpty) {
      return 'Name list is empty';
    }

    Set<String> nameSet = {};

    for (String name in nameList) {
      if (name.isEmpty) {
        return 'Name cannot be empty';
      }
      if (nameSet.contains(name)) {
        return 'Duplicate names are not allowed';
      }
      nameSet.add(name);
    }
    return null;
  }

  String _getUnit(GameRule gameRule) {
    switch (gameRule) {
      case GameRule.limitGame:
        return 'games';
      case GameRule.limitScore:
        return 'points';
      case GameRule.normal:
        return '';
    }
  }

  String _getTypeOfGameRule(GameRule gameRule) {
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
