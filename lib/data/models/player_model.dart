// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
@immutable
class Player extends Equatable {
  @HiveField(0)
  String name;

  @HiveField(1)
  int? score;

  @HiveField(2)
  bool? isWinner;

  Player({
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
