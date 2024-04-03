import 'package:calculate_card_score/domain/entities/player.dart';
import 'package:calculate_card_score/domain/entities/score.dart';

class Round {
  final int id;
  final int roundNumber;
  final List<Score> scores;
  final DateTime createdAt;
  final int scoreboardId;
  final List<Player> players; // Danh sách người chơi

  Round({
    required this.id,
    required this.roundNumber,
    required this.scores,
    required this.createdAt,
    required this.scoreboardId,
    required this.players,
  });
}