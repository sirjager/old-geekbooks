// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encpagesource.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EncPageSourceAdapter extends TypeAdapter<EncPageSource> {
  @override
  final int typeId = 0;

  @override
  EncPageSource read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EncPageSource(
      key: fields[0] as String,
      source: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, EncPageSource obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.source);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EncPageSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
