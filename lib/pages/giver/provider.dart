import 'package:geeklibrary/export/export.dart';

class DownloadExternallyProvider extends ChangeNotifier {
  bool _external = false;
  bool get external => _external;

  void changeMode() {
    _external = !_external;
    notifyListeners();
  }
}

final externalIndicator =
    ChangeNotifierProvider((_) => DownloadExternallyProvider());
