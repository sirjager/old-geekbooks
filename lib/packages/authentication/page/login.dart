import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

import 'package:geeklibrary/core/responsive/size/responsive_size.dart';
import 'package:geeklibrary/export/export.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  final Color greenColor = Color(0xFF00AF19);

  @override
  Widget build(BuildContext context) {
    bool buttonPressed = false;
    final TextEditingController _email = TextEditingController();
    final TextEditingController _pass = TextEditingController();

    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, info) {
          return Consumer(
            builder: (context, watch, child) {
              var theme = watch(themeProvider);
              return Container(
                margin: EdgeInsets.only(
                  left: R.w(info, 5),
                  right: R.w(info, 5),
                  top: R.h(info, 5),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: R.w(info, 2)),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: R.h(info, 5)),
                          child: Row(
                            children: [
                              KText(
                                "Login .",
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
                        Container(
                          height: R.h(info, 8),
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: R.h(info, 2),
                            left: R.w(info, 2),
                            right: R.w(info, 2),
                          ),
                          child: buildField(
                            info,
                            theme,
                            title: 'email',
                            controller: _email,
                            icon: Typicons.mail,
                          ),
                        ),
                        Container(
                          height: R.h(info, 8),
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: R.h(info, 2),
                            left: R.w(info, 2),
                            right: R.w(info, 2),
                          ),
                          child: buildField(
                            info,
                            theme,
                            icon: Typicons.key_outline,
                            controller: _pass,
                            title: "password",
                          ),
                        ),
                        SizedBox(height: 50.0),
                        KClickable(
                          enabled: !buttonPressed,
                          onPressed: () {
                            setState(() {
                              buttonPressed = true;
                            });
                            context.read(auth).signIn(_email.text, _pass.text);
                          },
                          height: R.h(info, 8),
                          width: R.w(info, 25),
                          child: buttonPressed
                              ? Center(child: CircularProgressIndicator())
                              : KText(
                                  "Login",
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
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
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
                                  gradient: LinearGradient(colors: [
                                    Colors.black,
                                    randomLightColor()
                                  ]),
                                )
                              : BoxDecoration(),
                        ),
                        SizedBox(height: R.h(info, 15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () => Get.to(() => SignupPage()),
                              child: KText(
                                'Signup',
                                size: R.f(info, 12),
                                color: theme.isDarkMode
                                    ? XColors.lightColor1
                                    : XColors.darkColor2,
                                weight: FontWeight.w500,
                                textDecoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildField(
    SizingInformation info,
    ThemeProvider theme, {
    required TextEditingController controller,
    required String title,
    required IconData icon,
  }) {
    return KClickable(
      enabled: false,
      onPressed: () {},
      height: R.h(info, 8),
      width: R.w(info, 80),
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
      child: CupertinoTextField(
        controller: controller,
        prefix: Container(
          margin: EdgeInsets.only(left: R.w(info, 3)),
          child: Icon(
            icon,
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
        placeholder: title,
        padding: EdgeInsets.all(R.h(info, 2)),
        placeholderStyle: TextStyle(
          fontFamily: 'MavenPro',
          fontWeight: FontWeight.w700,
          fontSize: R.f(info, 13.0),
          color: theme.isDarkMode ? Colors.black : Colors.grey.withOpacity(0.5),
        ),
        decoration: theme.isDarkMode
            ? BoxDecoration()
            : BoxDecoration(
                gradient: LinearGradient(
                  colors: theme.isDarkMode
                      ? [XColors.darkColor, XColors.darkColor1]
                      : [XColors.lightColor1, XColors.lightGray],
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
                    color: theme.isDarkMode ? Colors.black : Colors.black12,
                    offset: Offset(3, 3),
                    blurRadius: 2,
                  ),
                ],
              ),
      ),
    );
  }
}
