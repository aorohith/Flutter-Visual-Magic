// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

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
