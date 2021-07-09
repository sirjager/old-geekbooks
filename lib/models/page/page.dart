
class PageInfo {
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
  final String? currentPageUrl;
  final String? totalFiles;
  final String? totalPages;
  final String? pagesVisible;
  final String? currentPage;
  final String? sortSample;
  final String? showingResultsFrom;
  final String? showingResultsTo;
}

