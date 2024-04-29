// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoundAdapter extends TypeAdapter<Round> {
  @override
  final int typeId = 1;

  @override
  Round read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Round(
      id: fields[0] as int,
      createdAt: fields[1] as DateTime,
      scoreboardId: fields[2] as int,
      players: (fields[3] as List).cast<Player>(),
      note: fields[4] as String?,
      isDelete: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Round obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.scoreboardId)
      ..writeByte(3)
      ..write(obj.players)
      ..writeByte(4)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.isDelete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoundAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Round _$RoundFromJson(Map<String, dynamic> json) => Round(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      scoreboardId: json['scoreboardId'] as int,
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String?,
      isDelete: json['isDelete'] as bool? ?? false,
    );

Map<String, dynamic> _$RoundToJson(Round instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'scoreboardId': instance.scoreboardId,
      'players': instance.players,
      'note': instance.note,
      'isDelete': instance.isDelete,
    };
