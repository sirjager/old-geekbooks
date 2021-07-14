import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:geekbooks/ads/adprovider.dart';
import 'package:geekbooks/ads/adstate.dart';
import 'package:geekbooks/bundles/authentication/page/verification/verification_checkup.dart';
import 'package:geekbooks/core/theme/themeData.dart';
import 'package:geekbooks/models/book/encbook.dart';
import 'package:geekbooks/models/sauce/encpagesource.dart';
import 'package:geekbooks/provider/all_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bundles/authentication/page/login.dart';
import 'bundles/authentication/services/authentication_wrapper.dart';
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
  runApp(Phoenix(
    child: ProviderScope(
      overrides: [adStateProvider.overrideWithValue(adState)],
      child: MyApp(),
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
      home: AuthenticationWrapper(
        home: VerificationCheck(),
        login: LoginPage(),
      ),
    );
  }
}
