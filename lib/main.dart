import 'package:device_preview/device_preview.dart';
import 'package:geekbooks/models/download/downlenk.dart';
import 'package:geekbooks/models/page/page.dart';
import 'package:geekbooks/models/sort/sort.dart';
import 'package:geekbooks/provider/all_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'export/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PageInfoAdapter());
  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(DownLenksAdapter());
  Hive.registerAdapter(SortAdapter());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(ProviderScope(child: MyApp()));

  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => ProviderScope(child: MyApp()),
  //   ),
  // );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // ignore: unused_local_variable
    bool isDarkMode = watch(themeProvider).isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      title: 'GeekBooks',
      home: Dashboard(),
    );
  }
}
