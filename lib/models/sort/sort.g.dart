// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SortAdapter extends TypeAdapter<Sort> {
  @override
  final int typeId = 3;

  @override
  Sort read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sort(
      sortById: fields[0] as String?,
      sortByAuthor: fields[1] as String?,
      sortByTitle: fields[2] as String?,
      sortByPublisher: fields[3] as String?,
      sortByYear: fields[4] as String?,
      sortByPages: fields[5] as String?,
      sortByLanguage: fields[6] as String?,
      sortBySize: fields[7] as String?,
      sortByExtension: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Sort obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.sortById)
      ..writeByte(1)
      ..write(obj.sortByAuthor)
      ..writeByte(2)
      ..write(obj.sortByTitle)
      ..writeByte(3)
      ..write(obj.sortByPublisher)
      ..writeByte(4)
      ..write(obj.sortByYear)
      ..writeByte(5)
      ..write(obj.sortByPages)
      ..writeByte(6)
      ..write(obj.sortByLanguage)
      ..writeByte(7)
      ..write(obj.sortBySize)
      ..writeByte(8)
      ..write(obj.sortByExtension);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
