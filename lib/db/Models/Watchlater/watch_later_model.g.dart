// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_later_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

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
