// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      name: fields[0] as String,
      email: fields[1] as String,
      imgPath: fields[2] as String,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.imgPath)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavoritesAdapter extends TypeAdapter<Favorites> {
  @override
  final int typeId = 1;

  @override
  Favorites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorites(
      favVideo: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Favorites obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.favVideo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentModelAdapter extends TypeAdapter<RecentModel> {
  @override
  final int typeId = 2;

  @override
  RecentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentModel(
      recentPath: fields[0] as String,
      recentDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RecentModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.recentPath)
      ..writeByte(1)
      ..write(obj.recentDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      playListVideo: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlayListVideos obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playListName)
      ..writeByte(1)
      ..write(obj.playListVideo);
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

class WatchlaterModelAdapter extends TypeAdapter<WatchlaterModel> {
  @override
  final int typeId = 5;

  @override
  WatchlaterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchlaterModel(
      laterPath: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WatchlaterModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.laterPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchlaterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
