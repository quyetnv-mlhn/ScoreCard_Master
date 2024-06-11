import 'package:score_card_master/data/models/player_model.dart';
import 'package:score_card_master/data/models/round_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'score_board_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class ScoreBoard extends Equatable {
  const ScoreBoard({
    required this.players,
    required this.id,
    required this.currentScore,
    required this.rounds,
    required this.timestamp,
  });

  factory ScoreBoard.fromJson(Map<String, dynamic> json) =>
      _$ScoreBoardFromJson(json);

  @HiveField(0)
  final int id;

  @HiveField(1)
  final List<Player> players;

  @HiveField(2, defaultValue: [])
  final List<List<int>> currentScore;

  @HiveField(3, defaultValue: [])
  final List<Round> rounds;

  @HiveField(4)
  final DateTime timestamp;

  ScoreBoard copyWith({
    int? id,
    List<Player>? players,
    List<List<int>>? currentScore,
    List<Round>? rounds,
    DateTime? timestamp,
  }) {
    return ScoreBoard(
      id: id ?? this.id,
      players: players ?? this.players,
      currentScore: currentScore ?? this.currentScore,
      rounds: rounds ?? this.rounds,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() => _$ScoreBoardToJson(this);

  @override
  List<Object> get props => [
        id,
        players,
        currentScore,
        rounds,
        timestamp,
      ];
}
