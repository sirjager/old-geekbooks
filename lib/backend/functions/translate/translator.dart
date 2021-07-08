import 'package:translator/translator.dart';

final translator = GoogleTranslator();

Future<Translation> translate(String input,
    {String from = 'auto', String to = "en"}) async {
  var output = await translator.translate(input, from: from, to: to);
  return output;
}
