import 'package:geeklibrary/models/sort/sort.dart';

class SortProvider {
  Sort? sortAsObject(source) {
    final RegExp allSorts = new RegExp('Sort.results.by.*<\/a>');
    final sortList = allSorts.allMatches(source);
    List<TitleLink> allSortings = [];
    for (Match sort in sortList) {
      final sorting = sort
          .group(0)
          .toString()
          .replaceAll("</a>", "")
          .replaceAll("Sort results by ", "")
          .split(">")
          .first
          .replaceAll("'", "");
      final String title = sorting.split(" ").first;
      final String link = sorting.split(" ")[1].replaceAll("href=", "");
      allSortings.add(TitleLink(title.toLowerCase(), link));
    }

    String? idLink,
        authorLink,
        titleLink,
        publisherLink,
        yearLink,
        pagesLink,
        languageLink,
        sizeLink,
        extensionLink;

    for (TitleLink sort in allSortings) {
      switch (sort.title) {
        case "id":
          idLink = sort.link;
          break;
        case "author":
          authorLink = sort.link;
          break;
        case "title":
          titleLink = sort.link;
          break;
        case "publisher":
          publisherLink = sort.link;
          break;
        case "year":
          yearLink = sort.link;
          break;
        case "pages":
          pagesLink = sort.link;
          break;
        case "language":
          languageLink = sort.link;
          break;
        case "size":
          sizeLink = sort.link;
          break;
        case "extension":
          extensionLink = sort.link;
          break;
        default:
          break;
      }
    }
    final Sort sort = Sort(
      sortById: idLink,
      sortByAuthor: authorLink,
      sortByTitle: titleLink,
      sortByPublisher: publisherLink,
      sortByYear: yearLink,
      sortByPages: pagesLink,
      sortByLanguage: languageLink,
      sortBySize: sizeLink,
      sortByExtension: extensionLink,
    );
    return sort;
  }
}

class TitleLink {
  TitleLink(this.title, this.link);
  final String title;
  final String link;
}
