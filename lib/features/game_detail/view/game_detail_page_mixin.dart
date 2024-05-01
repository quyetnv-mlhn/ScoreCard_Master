part of 'game_detail_page.dart';

mixin GameDetailPageMixin on State<GameDetailView> {
  late final int countPlayer;
  List<TextEditingController> inputScoreEditingControllers = [];
  final noteController = TextEditingController();
  int roundNumber = 1;
  late ScoreBoard scoreBoard;
  String groupValueChooseWinner = '';

  @override
  void initState() {
    scoreBoard = widget.scoreBoard;
    countPlayer = scoreBoard.players.length;
    for (int i = 0; i < countPlayer; ++i) {
      inputScoreEditingControllers.add(
        TextEditingController(text: 0.toString()),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in inputScoreEditingControllers) {
      controller.dispose();
    }
    noteController.dispose();
    super.dispose();
  }

  void _onSubtractPointPressed(TextEditingController controller) {
    final score = int.tryParse(controller.text) ?? 0;
    controller.text = '${score - 1}';
  }

  void _onAddPointPressed(TextEditingController controller) {
    final score = int.tryParse(controller.text) ?? 0;
    controller.text = '${score + 1}';
  }

  void _onCancelInputScore() {
    Navigator.pop(context);
  }

  Future<void> _onSaveInputScore() async {
    final boardGameRepository = getIt<BoardGameRepository>();

    _checkValidateInputScore();

    try {
      final round = Round(
        id: roundNumber,
        createdAt: DateTime.now(),
        players: List.generate(
          countPlayer,
          (i) {
            final isWinner =
                groupValueChooseWinner == scoreBoard.players[i].name;
            return scoreBoard.players[i].copyWith(
              score: isWinner
                  ? 0
                  : int.tryParse(inputScoreEditingControllers[i].text) ?? 0,
              isWinner: isWinner,
            );
          },
        ),
        note: noteController.text,
        scoreboardId: scoreBoard.id!,
      );

      boardGameRepository.addRound(scoreBoard.id!, round);

      if (!mounted) return;
      context.read<GameDetailBloc>().add(GameDetailAddRound(round));

      ++roundNumber;
      _clearAllInputScore();
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  void _clearAllInputScore() {
    for (var controller in inputScoreEditingControllers) {
      controller.clear();
    }
    noteController.clear();
    groupValueChooseWinner = '';
  }

  void _onChangeGroupValueChooseWinner(
    String? value,
    GameDetailState state,
  ) {
    groupValueChooseWinner = value!;
    final winner =
        scoreBoard.players.firstWhere((player) => player.name == value);
    context.read<GameDetailBloc>().add(GameDetailChangeWinner(winner));
  }

  void _checkValidateInputScore() {
    if (groupValueChooseWinner.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text('Please choose winner'),
          duration: Duration(seconds: 1),
        ),
      );
      throw Exception('Please choose winner');
    }
  }
}
