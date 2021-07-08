// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KRequestAdapter extends TypeAdapter<KRequest> {
  @override
  final int typeId = 0;

  @override
  KRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KRequest(
      url: fields[0] as String,
      response: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, KRequest obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.response);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
