part of 'new_game_page.dart';

mixin NewGamePageMixin on State<NewGameView> {
  late TextEditingController valueGameRuleController;
  GameRule gameRuleSelected = GameRule.normal;
  bool isShowError = false;
  final quantityPlayer = [2, 3, 4, 5];
  List<TextEditingController> listNamePlayerControllers = [];

  @override
  void initState() {
    super.initState();
    valueGameRuleController = TextEditingController();
    for (var i = 0; i < 5; ++i) {
      listNamePlayerControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    super.dispose();
    valueGameRuleController.dispose();
    for (final nameController in listNamePlayerControllers) {
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

  Future<void> _onStartPressed(
    BuildContext context,
    NewGameState state, {
    bool isQuickStart = false,
  }) async {
    final boardGameRepository = getIt<BoardGameRepository>();

    ScoreBoard? boardGame;

    if (!context.mounted) {
      return;
    }
    if (!isQuickStart) {
      final nameList = <String>[];
      for (var i = 0; i < state.playerQuantity; ++i) {
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
      boardGame = ScoreBoard(
        players: List.generate(
          state.playerQuantity,
          (index) => Player(
            name: listNamePlayerControllers[index].text,
          ),
        ),
        currentScore: List.generate(state.playerQuantity,
            (_) => List.generate(state.playerQuantity, (_) => 0)),
      );
    } else {
      boardGame = ScoreBoard(
        players: List.generate(
          state.playerQuantity,
          (index) => Player(
            name: String.fromCharCode('A'.codeUnitAt(0) + index),
          ),
        ),
        currentScore: List.generate(state.playerQuantity,
            (_) => List.generate(state.playerQuantity, (_) => 0)),
      );
    }

    try {
      await boardGameRepository.addGame(boardGame).then((id) {
        debugPrint("id: $id");
        final boardGameCopy = boardGame!.copyWith(id: id);
        debugPrint(boardGameCopy.toJson().toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailPage(scoreBoard: boardGameCopy),
          ),
        );
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String? _validateNameList(List<String> nameList) {
    if (nameList.isEmpty) {
      return 'Name list is empty';
    }

    final nameSet = <String>{};

    for (var name in nameList) {
      name = name.trim();
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
