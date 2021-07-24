import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/pageheader/pageheader.dart';

class KWebView extends StatelessWidget {
  const KWebView({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageHeader(title: "Feedbacks"),
          Expanded(
            child: Consumer(
              builder: (context, watch, child) {
                bool isDark = watch(themeProvider).isDarkMode;
                return InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(url)),
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
        ],
      ),
    );
  }
}
