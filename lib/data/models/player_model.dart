
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Player extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int? score;

  @HiveField(2)
  final bool? isWinner;

  const Player({
    required this.name,
    this.score,
    this.isWinner,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  @override
  List<Object?> get props => [name, score, isWinner];

  Player copyWith({
    String? name,
    int? score,
    bool? isWinner,
  }) {
    return Player(
      name: name ?? this.name,
      score: score ?? this.score,
      isWinner: isWinner ?? this.isWinner,
    );
  }
}
