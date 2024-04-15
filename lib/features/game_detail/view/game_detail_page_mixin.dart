part of 'game_detail_page.dart';

mixin GameDetailPageMixin on State<GameDetailView> {
  final PlayerRepository playerRepository = PlayerRepository();
  List<Player> players = [];
  late final int countPlayer;

  @override
  void initState() {
    players = playerRepository.listPlayer;
    countPlayer = players.length;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
