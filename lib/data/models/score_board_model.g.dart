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
      id: fields[0] as int?,
      players: (fields[1] as List).cast<Player>(),
      currentScore: (fields[2] as List?)
          ?.map((dynamic e) => (e as List).cast<int>())
          ?.toList(),
    );
  }

  @override
  void write(BinaryWriter writer, ScoreBoard obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.players)
      ..writeByte(2)
      ..write(obj.currentScore);
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
      id: json['id'] as int?,
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentScore: (json['currentScore'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
    );

Map<String, dynamic> _$ScoreBoardToJson(ScoreBoard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'players': instance.players,
      'currentScore': instance.currentScore,
    };
