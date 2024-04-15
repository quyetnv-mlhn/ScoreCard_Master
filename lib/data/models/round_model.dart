import 'package:calculate_card_score/data/models/player_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'round_model.g.dart';

@JsonSerializable()
class Round {
  final int? id;
  final int roundNumber;
  final DateTime createdAt;
  final int scoreboardId;
  final List<Player> players;

  Round({
    this.id,
    required this.roundNumber,
    required this.createdAt,
    required this.scoreboardId,
    required this.players,
  });

  factory Round.fromJson(Map<String, dynamic> json) => _$RoundFromJson(json);
  Map<String, dynamic> toJson() => _$RoundToJson(this);
}
