// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downlenk.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownLenksAdapter extends TypeAdapter<DownLenks> {
  @override
  final int typeId = 2;

  @override
  DownLenks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownLenks(
      id: fields[0] as String,
      md5: fields[1] as String,
      get: fields[2] as String,
      cfa: fields[3] as String,
      ips: fields[4] as String,
      inf: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DownLenks obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.md5)
      ..writeByte(2)
      ..write(obj.get)
      ..writeByte(3)
      ..write(obj.cfa)
      ..writeByte(4)
      ..write(obj.ips)
      ..writeByte(5)
      ..write(obj.inf);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownLenksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
