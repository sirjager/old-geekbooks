import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/widgets/chip/chip.dart';
import 'package:string_validator/string_validator.dart';

class SizingInformationProvider extends ChangeNotifier {
  SizingInformation _info = SizingInformation();
  SizingInformation get info => _info;
  void updateSizingInfo(SizingInformation sizinginfo) {
    _info = sizinginfo;
    notifyListeners();
  }
}

class DrawerProvider extends ChangeNotifier {
  //!============> FOR USING DRAWER GLOBALY
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  void toggleDrawer() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}

class ThemeProvider extends ChangeNotifier {
  //!=========> FOR CHECKING AND CHANING SYSTEM THEMEMODE
  ThemeMode _mode = ThemeMode.light;
  bool get isDarkMode => _mode == ThemeMode.dark;
  void setMode(bool isDarkMode) {
    _mode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class NavigationProvider extends ChangeNotifier {
  //!=========> FOR CHANGING BETWEEN PAGES HOME NAVIGATION
  int _index = 0;
  int get current => _index;
  void changeTo(int changeTo) {
    _index = changeTo;
    notifyListeners();
  }
}

class SearchOptionProvider extends ChangeNotifier {
  KItem _selectedOption = KItem(index: 0, title: "Simple", active: true);
  KItem get selected => _selectedOption;
  void setSelection(KItem changeTo) {
    _selectedOption = changeTo;
    notifyListeners();
  }
}

class PJumper extends ChangeNotifier {
  TextEditingController _jumper = TextEditingController();
  TextEditingController get pageNoController => _jumper;

  void setJumper(String text) {
    bool isNum = isInt(text);
    if (isNum) {
      _jumper.text = text;
    } else {}
    notifyListeners();
  }

  void listenJumper(String text, int initial, int end) {
    bool isNum = isInt(text);
    if (isNum) {
      var value = int.parse(text);
      if (value >= initial && value <= end) {
      } else {
        _jumper.clear();
      }
    } else {
      _jumper.clear();
    }
    notifyListeners();
  }
}
