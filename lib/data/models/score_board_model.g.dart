// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_board_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScoreBoardAdapter extends TypeAdapter<ScoreBoard> {
  @override
  final int typeId = 0;

  @override
  ScoreBoard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScoreBoard(
      players: (fields[1] as List).cast<Player>(),
      id: fields[0] as int,
      currentScore: fields[2] == null
          ? []
          : (fields[2] as List)
              .map((dynamic e) => (e as List).cast<int>())
              .toList(),
      rounds: fields[3] == null ? [] : (fields[3] as List).cast<Round>(),
      timestamp: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ScoreBoard obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.players)
      ..writeByte(2)
      ..write(obj.currentScore)
      ..writeByte(3)
      ..write(obj.rounds)
      ..writeByte(4)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoreBoardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreBoard _$ScoreBoardFromJson(Map<String, dynamic> json) => ScoreBoard(
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int,
      currentScore: (json['currentScore'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      rounds: (json['rounds'] as List<dynamic>)
          .map((e) => Round.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ScoreBoardToJson(ScoreBoard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'players': instance.players,
      'currentScore': instance.currentScore,
      'rounds': instance.rounds,
      'timestamp': instance.timestamp.toIso8601String(),
    };
