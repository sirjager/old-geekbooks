import 'package:hive/hive.dart';

part 'page.g.dart';

@HiveType(typeId: 0)
class PageInfo extends HiveObject {
  PageInfo({
    this.totalFiles,
    this.totalPages,
    this.pagesVisible,
    this.currentPage,
    this.sortSample,
    this.showingResultsFrom,
    this.showingResultsTo,
    this.currentPageUrl,
  });

  @HiveField(0)
  final String? currentPageUrl;
  @HiveField(1)
  final String? totalFiles;
  @HiveField(2)
  final String? totalPages;
  @HiveField(3)
  final String? pagesVisible;
  @HiveField(4)
  final String? currentPage;
  @HiveField(5)
  final String? sortSample;
  @HiveField(6)
  final String? showingResultsFrom;
  @HiveField(7)
  final String? showingResultsTo;
}
