// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PageInfoAdapter extends TypeAdapter<PageInfo> {
  @override
  final int typeId = 0;

  @override
  PageInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PageInfo(
      totalFiles: fields[1] as String?,
      totalPages: fields[2] as String?,
      pagesVisible: fields[3] as String?,
      currentPage: fields[4] as String?,
      sortSample: fields[5] as String?,
      showingResultsFrom: fields[6] as String?,
      showingResultsTo: fields[7] as String?,
      currentPageUrl: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PageInfo obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.currentPageUrl)
      ..writeByte(1)
      ..write(obj.totalFiles)
      ..writeByte(2)
      ..write(obj.totalPages)
      ..writeByte(3)
      ..write(obj.pagesVisible)
      ..writeByte(4)
      ..write(obj.currentPage)
      ..writeByte(5)
      ..write(obj.sortSample)
      ..writeByte(6)
      ..write(obj.showingResultsFrom)
      ..writeByte(7)
      ..write(obj.showingResultsTo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
