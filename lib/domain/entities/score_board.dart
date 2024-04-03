import 'package:calculate_card_score/domain/entities/player.dart';
import 'package:calculate_card_score/domain/entities/round.dart';

class Scoreboard {
  final int id;
  final int numberOfPlayers;
  final List<Round> rounds;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? name; // Optional
  final List<Player> players; // Danh sách người chơi

  Scoreboard({
    required this.id,
    required this.numberOfPlayers,
    required this.rounds,
    required this.createdAt,
    required this.updatedAt,
    this.name,
    required this.players,
  });
}