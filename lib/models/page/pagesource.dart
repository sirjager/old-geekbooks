import 'package:hive/hive.dart';

part 'pagesource.g.dart';

@HiveType(typeId: 0)
class PageSource extends HiveObject {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final source;
  PageSource({required this.key, required this.source});
}
