import 'package:geekbooks/export/export.dart';

final drawerProvider = ChangeNotifierProvider((ref) => DrawerProvider());
final themeProvider = ChangeNotifierProvider((ref) => ThemeProvider());
final navigationProvider =
    ChangeNotifierProvider((ref) => NavigationProvider());
final infoProvider =
    ChangeNotifierProvider((ref) => SizingInformationProvider());
final searchOptionProvider =
    ChangeNotifierProvider((ref) => SearchOptionProvider());
final jumperProvider = ChangeNotifierProvider((ref) => PJumper());
