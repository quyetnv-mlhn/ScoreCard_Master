// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable()
class Player {
  String name;
  List<int>? scores;
  int? totalScore;

  Player({required this.name, this.scores, this.totalScore});

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  Player copyWith({
    String? name,
    List<int>? scores,
    int? totalScore,
  }) {
    return Player(
      name: name ?? this.name,
      scores: scores ?? this.scores,
      totalScore: totalScore ?? this.totalScore,
    );
  }
}
