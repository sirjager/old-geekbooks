import 'package:geeklibrary/export/export.dart';

class DownloadExternallyProvider extends ChangeNotifier {
  bool _external = false;
  bool get external => _external;

  void changeMode(bool value) {
    _external = value;
    notifyListeners();
  }
}

final externalIndicator =
    ChangeNotifierProvider((_) => DownloadExternallyProvider());
