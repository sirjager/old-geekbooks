import 'package:logger/logger.dart';

class Log {
  var _logs = Logger(printer: PrettyPrinter());
}

var log = Logger(
  printer: PrettyPrinter(methodCount: 0),
);
void i(String i) {
  Log()._logs.i(i);
}

void e(String e) {
  Log()._logs.i(e);
}

void w(String w) {
  Log()._logs.i(w);
}
