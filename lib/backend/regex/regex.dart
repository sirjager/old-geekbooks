class RegX {
  static RegExp get totalPages =>
      new RegExp('([0-9]+)*(,.\/\/.общее.число.страниц)');
  static RegExp get totalVisiblePage =>
      new RegExp('([0-9]+)*(,.\/\/.число.страниц,.видимых.одновременно)');
  static RegExp get currentPage =>
      new RegExp('([0-9]+)*(,.\/\/.номер.текущей.страницы)');

  static RegExp get downloads => new RegExp('href="((?:[^"]|"")*)">([A-z]+)');
}
