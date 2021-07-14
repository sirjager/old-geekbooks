import 'package:geeklibrary/backend/regex/regex.dart';
import 'package:geeklibrary/models/lenk/lenk.dart';

class Grabber {
  static List<Lenk> getLenks(_downSource) {
    final downReg = RegX.downloads;
    List<Lenk> _lenx = [];
    final _all = downReg.allMatches(_downSource).toList();
    for (int i = 0; i < 4; i++) {
      if (_all[i].group(2) != null && _all[i].group(1) != null) {
        final _ti = _all[i].group(2).toString().toLowerCase();
        final _le = _all[i].group(1)!;
        _lenx.add(Lenk(_ti, _le));
      }
    }
    if (_lenx.length < 1) return [];
    return _lenx;
  }
}
