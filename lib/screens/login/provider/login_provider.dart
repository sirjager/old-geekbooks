import 'package:geeklibrary/export/export.dart';

class MALAProvider extends ChangeNotifier {
  final TextEditingController _zale = TextEditingController(text: 'gimi@ha.ni');
  TextEditingController get mala => _zale;

  void setMala(String mala) {
    _zale.text = mala;
    notifyListeners();
  }
}

class PASAProvider extends ChangeNotifier {
  final TextEditingController _pale = TextEditingController();
  TextEditingController get pasa => _pale;

  bool _isHidden = true;
  bool get isHidden => _isHidden;
  void setPasa(String pasa) {
    _pale.text = pasa;
    notifyListeners();
  }

  void toggleHide(bool isHidden) {
    _isHidden = isHidden;
    notifyListeners();
  }
}

class PNAMEProvider extends ChangeNotifier {
  final TextEditingController __name = TextEditingController();
  TextEditingController get name => __name;

  bool _isHidden = true;
  bool get isHidden => _isHidden;
  void setname(String _name) {
    __name.text = _name;
    notifyListeners();
  }

  void toggleHide(bool isHidden) {
    _isHidden = isHidden;
    notifyListeners();
  }
}

final mailProvider = ChangeNotifierProvider((ref) => MALAProvider());
final pasaProvider = ChangeNotifierProvider((ref) => PASAProvider());
final nameProvider = ChangeNotifierProvider((ref) => PNAMEProvider());
