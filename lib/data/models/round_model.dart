import 'package:calculate_card_score/data/models/player_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'round_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)

class Round extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final DateTime createdAt;

  @HiveField(2)
  final int scoreboardId;

  @HiveField(3)
  final List<Player> players;

  @HiveField(4)
  final String? note;

  @HiveField(5)
  final bool? isDelete;

  const Round({
    required this.id,
    required this.createdAt,
    required this.scoreboardId,
    required this.players,
    this.note,
    this.isDelete = false,
  });

  factory Round.fromJson(Map<String, dynamic> json) => _$RoundFromJson(json);
  Map<String, dynamic> toJson() => _$RoundToJson(this);

  @override
  List<Object?> get props => [
        id,
        createdAt,
        scoreboardId,
        players,
        note,
        isDelete,
      ];
}
