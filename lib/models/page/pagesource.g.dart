// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagesource.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PageSourceAdapter extends TypeAdapter<PageSource> {
  @override
  final int typeId = 0;

  @override
  PageSource read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PageSource(
      fields[0] as String,
      fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, PageSource obj) {
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
      other is PageSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
