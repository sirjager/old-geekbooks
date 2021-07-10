import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/models/book/encbook.dart';

class CryptionCalls {
  static encrypt(Book book) => EncBook.buildEnc(book);
  static decrypt(EncBook encBook) => EncBook.buildBook(encBook);
}
