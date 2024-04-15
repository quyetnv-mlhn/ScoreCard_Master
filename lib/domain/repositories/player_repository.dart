import 'package:calculate_card_score/data/models/player_model.dart';

class PlayerRepository {
  static final PlayerRepository _instance = PlayerRepository._internal();

  factory PlayerRepository() {
    return _instance;
  }

  PlayerRepository._internal();

  final List<Player> _listPlayer = [];

  List<Player> get listPlayer => _listPlayer;

  void addPlayer(Player player) {
    _listPlayer.add(player);
  }

  void removePlayer(Player player) {
    _listPlayer.remove(player);
  }

  void removeAllPlayer() {
    _listPlayer.clear();
  }
}
