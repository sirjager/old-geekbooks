import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/bundles/authentication/export/export.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/backend/functions/math/colors_genrator.dart';
import 'package:geeklibrary/core/responsive/size/responsive_size.dart';

class SignupPage extends ConsumerWidget {
  final formKey = new GlobalKey<FormState>();
  final Color greenColor = Color(0xFF00AF19);

  @override
  Widget build(BuildContext context, ScopedReader read) {
    var theme = read(themeProvider);
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, info) {
          var _email = context.read(emailFieldProvider).email;
          var _password = context.read(passwordFieldProvider).controller.text;
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: R.w(info, 5), vertical: R.h(info, 5)),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: R.w(info, 2)),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: R.h(info, 5)),
                      child: Row(
                        children: [
                          KText(
                            "Signup .",
                            size: R.f(info, 50.0),
                            font: "MavenPro",
                            weight: FontWeight.bold,
                            color: theme.isDarkMode
                                ? XColors.deepDark
                                : XColors.darkColor2,
                            shadows: [
                              Shadow(
                                color: theme.isDarkMode
                                    ? XColors.darkColor1
                                    : Colors.black26,
                                offset: Offset(4, 4),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: R.h(info, 10)),
                    buildField(
                      info,
                      theme,
                      Consumer(
                        builder: (context, watch, child) {
                          var _nameProvider = watch(nameFieldProvider);
                          return CupertinoTextField(
                            prefix: Container(
                              margin: EdgeInsets.only(left: R.w(info, 3)),
                              child: Icon(
                                Typicons.user_outline,
                                color: XColors.grayText1,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: R.f(info, 13),
                              fontWeight: FontWeight.w500,
                              color: theme.isDarkMode
                                  ? XColors.grayText1
                                  : Colors.black.withOpacity(0.5),
                            ),
                            placeholder: 'name',
                            padding: EdgeInsets.all(R.h(info, 2)),
                            placeholderStyle: TextStyle(
                              fontFamily: 'MavenPro',
                              fontWeight: FontWeight.w700,
                              fontSize: R.f(info, 13.0),
                              color: theme.isDarkMode
                                  ? Colors.black
                                  : Colors.grey.withOpacity(0.5),
                            ),
                            onChanged: (value) => _nameProvider.setName(value),
                            decoration: theme.isDarkMode
                                ? BoxDecoration()
                                : BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: theme.isDarkMode
                                          ? [
                                              XColors.darkColor,
                                              XColors.darkColor1
                                            ]
                                          : [
                                              XColors.lightColor1,
                                              XColors.lightGray
                                            ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.isDarkMode
                                            ? XColors.darkColor1
                                            : XColors.lightColor1,
                                        offset: Offset(-3, -3),
                                        blurRadius: theme.isDarkMode ? 2 : 0,
                                      ),
                                      BoxShadow(
                                        color: theme.isDarkMode
                                            ? Colors.black
                                            : Colors.black12,
                                        offset: Offset(3, 3),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                          );
                        },
                      ),
                    ),
                    buildField(
                      info,
                      theme,
                      Consumer(
                        builder: (context, watch, child) {
                          var _emailProvider = watch(emailFieldProvider);
                          return CupertinoTextField(
                            prefix: Container(
                              margin: EdgeInsets.only(left: R.w(info, 3)),
                              child: Icon(
                                Typicons.mail,
                                color: XColors.grayText1,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: R.f(info, 13),
                              fontWeight: FontWeight.w500,
                              color: theme.isDarkMode
                                  ? XColors.grayText1
                                  : Colors.black.withOpacity(0.5),
                            ),
                            placeholder: 'email',
                            padding: EdgeInsets.all(R.h(info, 2)),
                            placeholderStyle: TextStyle(
                              fontFamily: 'MavenPro',
                              fontWeight: FontWeight.w700,
                              fontSize: R.f(info, 13.0),
                              color: theme.isDarkMode
                                  ? Colors.black
                                  : Colors.grey.withOpacity(0.5),
                            ),
                            onChanged: (value) =>
                                _emailProvider.setEmail(value),
                            decoration: theme.isDarkMode
                                ? BoxDecoration()
                                : BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: theme.isDarkMode
                                          ? [
                                              XColors.darkColor,
                                              XColors.darkColor1
                                            ]
                                          : [
                                              XColors.lightColor1,
                                              XColors.lightGray
                                            ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.isDarkMode
                                            ? XColors.darkColor1
                                            : XColors.lightColor1,
                                        offset: Offset(-3, -3),
                                        blurRadius: theme.isDarkMode ? 2 : 0,
                                      ),
                                      BoxShadow(
                                        color: theme.isDarkMode
                                            ? Colors.black
                                            : Colors.black12,
                                        offset: Offset(3, 3),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                          );
                        },
                      ),
                    ),
                    buildField(
                      info,
                      theme,
                      Consumer(
                        builder: (context, watch, child) {
                          var _passwordProvider = watch(passwordFieldProvider);
                          return CupertinoTextField(
                            prefix: Container(
                              margin: EdgeInsets.only(left: R.w(info, 3)),
                              child: Icon(
                                Typicons.key_outline,
                                color: XColors.grayText1,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: R.f(info, 13),
                              fontWeight: FontWeight.w500,
                              color: theme.isDarkMode
                                  ? XColors.grayText1
                                  : Colors.black.withOpacity(0.5),
                            ),
                            placeholder: 'password',
                            placeholderStyle: TextStyle(
                              fontFamily: 'MavenPro',
                              fontWeight: FontWeight.w700,
                              fontSize: R.f(info, 13.0),
                              color: theme.isDarkMode
                                  ? Colors.black
                                  : Colors.grey.withOpacity(0.5),
                            ),
                            padding: EdgeInsets.all(R.h(info, 2)),
                            // obscureText: true,
                            onChanged: (value) =>
                                _passwordProvider.setPassword(value),
                            decoration: theme.isDarkMode
                                ? BoxDecoration()
                                : BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: theme.isDarkMode
                                          ? [
                                              XColors.darkColor,
                                              XColors.darkColor1
                                            ]
                                          : [
                                              XColors.lightColor1,
                                              XColors.lightGray
                                            ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.isDarkMode
                                            ? XColors.darkColor1
                                            : XColors.lightColor1,
                                        offset: Offset(-3, -3),
                                        blurRadius: theme.isDarkMode ? 2 : 0,
                                      ),
                                      BoxShadow(
                                        color: theme.isDarkMode
                                            ? Colors.black
                                            : Colors.black12,
                                        offset: Offset(3, 3),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 50.0),
                    KClickable(
                      enabled: _password.length > 7 ? true : false,
                      onPressed: () =>
                          context.read(auth).signUp(_email, _password),
                      height: R.h(info, 8),
                      width: R.w(info, 25),
                      child: KText(
                        "Signup",
                        weight: FontWeight.bold,
                        color: theme.isDarkMode
                            ? XColors.lightColor1
                            : XColors.darkColor2,
                      ),
                      topDeco: theme.isDarkMode
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                colors: theme.isDarkMode
                                    ? [XColors.darkColor, XColors.darkColor1]
                                    : [XColors.lightColor1, XColors.lightGray],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                colors: theme.isDarkMode
                                    ? [XColors.darkColor, XColors.darkColor1]
                                    : [XColors.lightColor1, XColors.lightGray],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.isDarkMode
                                      ? XColors.darkColor1
                                      : XColors.lightColor1,
                                  offset: Offset(-3, -3),
                                  blurRadius: theme.isDarkMode ? 2 : 0,
                                ),
                                BoxShadow(
                                  color: theme.isDarkMode
                                      ? Colors.black
                                      : Colors.black12,
                                  offset: Offset(3, 3),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                      bottomDeco: theme.isDarkMode
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                  colors: [Colors.black, randomLightColor()]),
                            )
                          : BoxDecoration(),
                    ),
                    SizedBox(height: R.h(info, 15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: KText(
                            'Go back',
                            size: R.f(info, 12),
                            color: theme.isDarkMode
                                ? XColors.lightColor1
                                : XColors.darkColor2,
                            weight: FontWeight.w500,
                            textDecoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: R.h(info, 15)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildField(SizingInformation info, ThemeProvider theme, Widget child) {
    return Container(
      height: R.h(info, 8),
      width: double.infinity,
      margin: EdgeInsets.only(
        top: R.h(info, 2),
        left: R.w(info, 2),
        right: R.w(info, 2),
      ),
      child: KClickable(
        onPressed: () {},
        height: R.h(info, 8),
        width: R.w(info, 80),
        child: child,
        topDeco: theme.isDarkMode
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: theme.isDarkMode
                      ? [XColors.darkColor, XColors.darkColor1]
                      : [XColors.lightColor1, XColors.lightGray],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(24),
              ),
        bottomDeco: theme.isDarkMode
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient:
                    LinearGradient(colors: [Colors.black, randomLightColor()]),
              )
            : BoxDecoration(),
        enabled: false,
      ),
    );
  }
}
