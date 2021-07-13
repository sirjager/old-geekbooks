import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geekbooks/ads/adprovider.dart';
import 'package:geekbooks/ads/adstate.dart';
import 'package:geekbooks/core/theme/themeData.dart';
import 'package:geekbooks/models/book/encbook.dart';
import 'package:geekbooks/models/sauce/encpagesource.dart';
import 'package:geekbooks/packages/authentication/page/login.dart';
import 'package:geekbooks/packages/authentication/page/signup.dart';
import 'package:geekbooks/provider/all_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'export/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  final initialization = MobileAds.instance.initialize();
  final adState = AdState(initialization: initialization);
  await Hive.initFlutter();
  Hive.registerAdapter(EncPageSourceAdapter());
  Hive.registerAdapter(EncBookAdapter());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(ProviderScope(
    overrides: [adStateProvider.overrideWithValue(adState)],
    // child: MyApp(),

    child: DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  ));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    bool isDarkMode = watch(themeProvider).isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(
        isDarkMode ? AppTheme.systemUiDark : AppTheme.systemUiLight);
    return GetMaterialApp(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.themeDark,
      theme: AppTheme.themeLight,
      title: 'GeekBooks',
      home: LoginPage(),
    );
  }
}
