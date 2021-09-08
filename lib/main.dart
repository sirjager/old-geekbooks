import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geeklibrary/core/theme/themeData.dart';
import 'package:geeklibrary/models/book/encbook.dart';
import 'package:geeklibrary/models/sauce/encpagesource.dart';
import 'package:geeklibrary/packages/authentication/services/authentication_wrapper.dart';
import 'package:geeklibrary/provider/all_provider.dart';
import 'package:geeklibrary/screens/welcome/welcome.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'export/export.dart';
import 'screens/login/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(EncPageSourceAdapter());
  Hive.registerAdapter(EncBookAdapter());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    bool isDarkMode = watch(themeProvider).isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(
        isDarkMode ? AppTheme.systemUiDark : AppTheme.systemUiLight);
    return ScreenUtilInit(
      designSize: Size(1080, 2340),
      builder: () => GetMaterialApp(
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.themeDark,
        theme: AppTheme.themeLight,
        title: 'GeekLibrary',
        home: AuthenticationWrapper(
          login: LoginScreen(),
          home: Dashboard(),
        ),
        // WelcomeScreen(),
      ),
    );
  }
}
