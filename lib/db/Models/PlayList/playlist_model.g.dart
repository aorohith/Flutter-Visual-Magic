// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayListNameAdapter extends TypeAdapter<PlayListName> {
  @override
  final int typeId = 3;

  @override
  PlayListName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListName(
      playListName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlayListName obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.playListName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayListVideosAdapter extends TypeAdapter<PlayListVideos> {
  @override
  final int typeId = 4;

  @override
  PlayListVideos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListVideos(
      playListName: fields[0] as String,
      playListSong: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlayListVideos obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playListName)
      ..writeByte(1)
      ..write(obj.playListSong);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListVideosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
