class RegX {
  static get totalPages => new RegExp('([0-9]+)*(,.\/\/.общее.число.страниц)');
  static get totalVisiblePage =>
      new RegExp('([0-9]+)*(,.\/\/.число.страниц,.видимых.одновременно)');
  static get currentPage =>
      new RegExp('([0-9]+)*(,.\/\/.номер.текущей.страницы)');
}
