import 'package:geeklibrary/export/export.dart';

class DrawerItemsProvider extends ChangeNotifier {
  int _selected = 0;
  int get selected => _selected;
  void select(int index) {
    _selected = index;
    notifyListeners();
  }
}

final drawerItems = ChangeNotifierProvider((ref) => DrawerItemsProvider());
