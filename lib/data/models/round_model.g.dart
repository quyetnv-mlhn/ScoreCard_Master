// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Round _$RoundFromJson(Map<String, dynamic> json) => Round(
      id: json['id'] as int?,
      roundNumber: json['roundNumber'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      scoreboardId: json['scoreboardId'] as int,
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoundToJson(Round instance) => <String, dynamic>{
      'id': instance.id,
      'roundNumber': instance.roundNumber,
      'createdAt': instance.createdAt.toIso8601String(),
      'scoreboardId': instance.scoreboardId,
      'players': instance.players,
    };
