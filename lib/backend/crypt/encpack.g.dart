// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encpack.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EncPackAdapter extends TypeAdapter<EncPack> {
  @override
  final int typeId = 0;

  @override
  EncPack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EncPack(
      query: fields[0] as String,
      pack: fields[1] as PagePack,
    );
  }

  @override
  void write(BinaryWriter writer, EncPack obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.query)
      ..writeByte(1)
      ..write(obj.pack);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EncPackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
