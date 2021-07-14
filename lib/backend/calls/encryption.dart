import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/models/book/encbook.dart';
import 'package:geeklibrary/models/sauce/encpagesource.dart';
import 'package:geeklibrary/models/sauce/pagesource.dart';

class CryptionCalls {
  static EncPageSource encryptSauce(PageSource sauce) =>
      EncPageSource.buildEnc(sauce);
  static PageSource decryptSauce(EncPageSource encsauce) =>
      EncPageSource.buildSauce(encsauce);
  static EncBook encryptBok(Book book) => EncBook.buildEnc(book);
  static Book decryptBok(EncBook encBook) => EncBook.buildBook(encBook);
}
