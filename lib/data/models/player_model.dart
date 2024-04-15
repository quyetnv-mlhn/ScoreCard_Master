import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable()
class Player {
  final String name;
  final List<int>? scores;
  final int? totalScore;

  Player({required this.name, this.scores, this.totalScore});

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
