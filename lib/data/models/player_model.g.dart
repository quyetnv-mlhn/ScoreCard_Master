// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      name: json['name'] as String,
      scores: (json['scores'] as List<dynamic>?)?.map((e) => e as int).toList(),
      totalScore: json['totalScore'] as int?,
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'name': instance.name,
      'scores': instance.scores,
      'totalScore': instance.totalScore,
    };