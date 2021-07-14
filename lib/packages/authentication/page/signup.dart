import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class SignupPage extends ConsumerWidget {
  final formKey = new GlobalKey<FormState>();
  final Color greenColor = Color(0xFF00AF19);
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context, ScopedReader read) {
    var theme = read(themeProvider);
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, info) {
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
                      label: "email",
                      icon: Typicons.mail,
                      controller: _email,
                    ),
                    buildField(
                      info,
                      theme,
                      label: "password",
                      controller: _pass,
                      icon: Typicons.key_outline,
                    ),
                    SizedBox(height: 50.0),
                    KClickable(
                      enabled: _pass.text.length > 7 ? true : false,
                      onPressed: () =>
                          context.read(auth).signUp(_email.text, _pass.text),
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
                        OutlinedButton(
                          onPressed: () => Get.back(),
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildField(
    SizingInformation info,
    ThemeProvider theme, {
    required IconData icon,
    required TextEditingController controller,
    required String label,
  }) {
    return Container(
      height: R.h(info, 8),
      width: double.infinity,
      margin: EdgeInsets.only(
        top: R.h(info, 2),
        left: R.w(info, 2),
        right: R.w(info, 2),
      ),
      child: KClickable(
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
          placeholder: label,
          padding: EdgeInsets.all(R.h(info, 2)),
          placeholderStyle: TextStyle(
            fontFamily: 'MavenPro',
            fontWeight: FontWeight.w700,
            fontSize: R.f(info, 13.0),
            color:
                theme.isDarkMode ? Colors.black : Colors.grey.withOpacity(0.5),
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
      ),
    );
  }
}
