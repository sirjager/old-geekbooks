import 'package:geekbooks/backend/export/backend_export.dart';
import 'package:hive/hive.dart';

part 'encpack.g.dart';

@HiveType(typeId: 0)
class EncPack extends HiveObject {
  EncPack({
    required this.query,
    required this.pack,
  });

  @HiveField(0)
  final String query;
  @HiveField(1)
  final PagePack pack;
}
