import 'package:hive/hive.dart';

part 'sort.g.dart';

@HiveType(typeId: 3)
class Sort extends HiveObject {
  Sort({
    required this.sortById,
    required this.sortByAuthor,
    required this.sortByTitle,
    required this.sortByPublisher,
    required this.sortByYear,
    required this.sortByPages,
    required this.sortByLanguage,
    required this.sortBySize,
    required this.sortByExtension,
  });

  @HiveField(0)
  final String? sortById;
  @HiveField(1)
  final String? sortByAuthor;
  @HiveField(2)
  final String? sortByTitle;
  @HiveField(3)
  final String? sortByPublisher;
  @HiveField(4)
  final String? sortByYear;
  @HiveField(5)
  final String? sortByPages;
  @HiveField(6)
  final String? sortByLanguage;
  @HiveField(7)
  final String? sortBySize;
  @HiveField(8)
  final String? sortByExtension;
}
