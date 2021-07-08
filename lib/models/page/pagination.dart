class Pageination {
  Pageination({
    required this.currentPageNumber,
    this.nextPageNumber,
    this.prevPageNumber,
    required this.totalPageNumber,
    this.hasNext,
    this.hasPrev,
    this.nextPageURL,
    this.prevPageUrl,
    required this.currentPageUrl,
  });

  final int currentPageNumber;
  final int? nextPageNumber;
  final int? prevPageNumber;
  final int totalPageNumber;
  final bool? hasNext;
  final bool? hasPrev;
  final String? nextPageURL;
  final String? prevPageUrl;
  final String currentPageUrl;
}
