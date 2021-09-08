import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geeklibrary/core/responsive/builder/responsive_builder.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/pageheader/pageheader.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class KWebView extends StatefulWidget {
  KWebView({Key? key, required this.title, required this.url})
      : super(key: key);
  final String url;
  final String title;

  @override
  _KWebViewState createState() => _KWebViewState();
}

class _KWebViewState extends State<KWebView> {
  late final bannerController;

  @override
  void initState() {
    bannerController = BannerAdController();
    super.initState();
  }

  @override
  void dispose() {
    bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Container(
            child: Column(
              children: [
                PageHeader(title: widget.title),
                Expanded(
                  child: Container(
                    child: Consumer(
                      builder: (context, watch, child) {
                        bool isDark = watch(themeProvider).isDarkMode;
                        return InAppWebView(
                          initialUrlRequest:
                              URLRequest(url: Uri.parse(widget.url)),
                          initialOptions: InAppWebViewGroupOptions(
                            android: AndroidInAppWebViewOptions(
                              saveFormData: false,
                              forceDark: isDark
                                  ? AndroidForceDark.FORCE_DARK_ON
                                  : AndroidForceDark.FORCE_DARK_OFF,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // feedbackAd(100, 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
