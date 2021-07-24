import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geeklibrary/ads/adprovider.dart';
import 'package:geeklibrary/ads/adstate.dart';
import 'package:geeklibrary/core/theme/themeData.dart';
import 'package:geeklibrary/models/book/encbook.dart';
import 'package:geeklibrary/models/sauce/encpagesource.dart';

import 'package:geeklibrary/provider/all_provider.dart';
import 'package:geeklibrary/screens/welcome/welcome.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'export/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final initialization = MobileAds.instance.initialize();
  final adState = AdState(initialization: initialization);
  await Hive.initFlutter();
  Hive.registerAdapter(EncPageSourceAdapter());
  Hive.registerAdapter(EncBookAdapter());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => Phoenix(
        child: ProviderScope(
          overrides: [adStateProvider.overrideWithValue(adState)],
          child: MyApp(),
        ),
      ),
    ),
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
        home: WelcomeScreen(),
      ),
    );
  }
}
