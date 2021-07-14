import 'package:geeklibrary/export/export.dart';

final drawerProvider = ChangeNotifierProvider((ref) => DrawerProvider());
final themeProvider = ChangeNotifierProvider((ref) => ThemeProvider());
final infoProvider = ChangeNotifierProvider((ref) => PSizingInfo());
final navigationProvider =
    ChangeNotifierProvider((ref) => NavigationProvider());

final searchOptionProvider =
    ChangeNotifierProvider((ref) => SearchOptionProvider());
final jumperProvider = ChangeNotifierProvider((ref) => PJumper());

final gridViewProvider = ChangeNotifierProvider((ref) => PGridView());
final blackNWhiteProvider = ChangeNotifierProvider((ref) => PBlackNWhite());
