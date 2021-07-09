import 'package:hive/hive.dart';

part 'pagesource.g.dart';

@HiveType(typeId: 0)
class PageSource extends HiveObject {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final source;
  PageSource(this.key, this.source);
}
