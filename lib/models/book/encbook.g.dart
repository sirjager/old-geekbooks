// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encbook.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EncBookAdapter extends TypeAdapter<EncBook> {
  @override
  final int typeId = 2;

  @override
  EncBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EncBook(
      id: fields[0] as String?,
      md5: fields[1] as String?,
      title: fields[2] as String?,
      author: fields[3] as String?,
      series: fields[4] as String?,
      publisher: fields[5] as String?,
      year: fields[6] as String?,
      language: fields[7] as String?,
      pages: fields[8] as String?,
      exten: fields[9] as String?,
      torrent: fields[10] as String?,
      coverURL: fields[11] as String?,
      desc: fields[12] as String?,
      tags: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EncBook obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.md5)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.series)
      ..writeByte(5)
      ..write(obj.publisher)
      ..writeByte(6)
      ..write(obj.year)
      ..writeByte(7)
      ..write(obj.language)
      ..writeByte(8)
      ..write(obj.pages)
      ..writeByte(9)
      ..write(obj.exten)
      ..writeByte(10)
      ..write(obj.torrent)
      ..writeByte(11)
      ..write(obj.coverURL)
      ..writeByte(12)
      ..write(obj.desc)
      ..writeByte(13)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EncBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
