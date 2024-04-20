part of 'game_detail_page.dart';

mixin GameDetailPageMixin on State<GameDetailView> {
  final PlayerRepository playerRepository = PlayerRepository();
  List<Player> players = [];
  late final int countPlayer;
  List<TextEditingController> inputScoreEditingControllers = [];
  final noteController = TextEditingController();
  int roundNumber = 1;

  @override
  void initState() {
    players = List.of(playerRepository.listPlayer);
    countPlayer = players.length;
    for (int i = 0; i < countPlayer; ++i) {
      inputScoreEditingControllers.add(TextEditingController());
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
    final score = int.tryParse(controller.text) ?? 1;

    if (score - 1 < 0) return;

    controller.text = '${score - 1}';
  }

  void _onAddPointPressed(TextEditingController controller) {
    final score = int.tryParse(controller.text) ?? 0;
    controller.text = '${score + 1}';
  }

  void _onCancelInputScore() {
    Navigator.pop(context);
  }

  void _onSaveInputScore() {
    final round = Round(
      roundNumber: roundNumber,
      createdAt: DateTime.now(),
      players: [
        for (int i = 0; i < countPlayer; ++i)
          players[i].copyWith(scores: [
            for (int j = 0; j < countPlayer; ++j)
              int.tryParse(inputScoreEditingControllers[j].text) ?? 0
          ])
      ],
    );

    context.read<GameDetailBloc>().add(GameDetailAddRound(round));
    _clearAllInputScore();
    Navigator.pop(context);
  }

  void _clearAllInputScore() {
    for (var controller in inputScoreEditingControllers) {
      controller.clear();
    }
  }
}
