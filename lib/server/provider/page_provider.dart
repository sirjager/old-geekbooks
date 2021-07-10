import 'package:geekbooks/backend/constants/api_strings.dart';
import 'package:geekbooks/backend/export/backend_export.dart';
import 'package:geekbooks/backend/regex/regex.dart';
import 'package:geekbooks/models/page/page.dart';

class PageProvider {
  PageInfo pageAsObject(source)  {
    final totalNumberOfPages =
        RegX.totalPages.allMatches(source).first.group(1);
    final totalNumberOfPagesVisible =
        RegX.totalVisiblePage.allMatches(source).first.group(1);
    final currentPageNumber =
        RegX.currentPage.allMatches(source).first.group(1);
    final String sortSample = source
        .split(Str.sortURL)[1]
        .split(Str.sortURL1)
        .first
        .replaceAll(Str.space, Str.none)
        .replaceAll(Str.quotDouble, Str.none)
        .toString()
        .replaceAll(Str.newLine, Str.none);
    final String currentPageUrl = ApiLenks.genisUrl +
        sortSample.toString() +
        currentPageNumber.toString();
    String? showingResultsFrom, showingResultsTo;
    final String totalNumberOfFiles =
        source.split(Str.filesFound).first.split(Str.rightArrow).last;
    int filesNumber = int.parse(totalNumberOfFiles);
    if (filesNumber > 0) {
      showingResultsFrom = source
          .split(Str.showingResultsFrom)
          .last
          .split(Str.leftArrow)
          .first
          .split(Str.to)
          .first
          .replaceAll(Str.space, Str.none);
      showingResultsTo = source
          .split(Str.showingResultsFrom)
          .last
          .split(Str.leftArrow)
          .first
          .split(Str.to)
          .last
          .replaceAll(Str.space, Str.none);
    }

    final pageDetails = PageInfo(
      totalFiles: totalNumberOfFiles,
      totalPages: totalNumberOfPages,
      pagesVisible: totalNumberOfPagesVisible,
      currentPage: currentPageNumber,
      sortSample: sortSample,
      showingResultsFrom: showingResultsFrom,
      showingResultsTo: showingResultsTo,
      currentPageUrl: currentPageUrl,
    );
    return pageDetails;
  }
}
