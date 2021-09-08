import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/core/dialog/dialogs.dart';
import 'package:geeklibrary/core/responsive/info/sizing_info.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/screens/login/provider/login_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:string_validator/string_validator.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Container(
            child: Consumer(
              builder: (context, watch, child) {
                var theme = watch(themeProvider);
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Opacity(
                        opacity: theme.isDarkMode ? 0.2 : 0.7,
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: Image.asset(
                            "assets/images/shapes/login_bottom.png",
                            width: R.w(info, 50),
                            color: theme.isDarkMode ? Colors.white30 : null,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Opacity(
                        opacity: 0.2,
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: Image.asset(
                            "assets/images/shapes/signup_top.png",
                            width: R.w(info, 40),
                            color: theme.isDarkMode ? Colors.white12 : null,
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(seconds: 3),
                      curve: Curves.fastOutSlowIn,
                      bottom: theme.isDarkMode ? R.h(info, 20) : R.h(info, 80),
                      left: theme.isDarkMode ? R.w(info, 1) : R.w(info, 85),
                      child: Container(
                        height: R.w(info, 30),
                        width: R.w(info, 30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.indigo.withOpacity(0.1),
                              Colors.blueGrey.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                    buildBody(info),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Container buildBody(SizingInformation info) {
    return Container(
      margin: EdgeInsets.only(top: R.appbarHeight),
      child: Consumer(
        builder: (context, watch, read) {
          var theme = watch(themeProvider);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: R.h(info, 5),
                margin: EdgeInsets.symmetric(horizontal: R.w(info, 4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          EvaIcons.arrowIosBack,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Shimmer.fromColors(
                        period: Duration(seconds: 5),
                        direction: ShimmerDirection.rtl,
                        highlightColor:
                            theme.isDarkMode ? Colors.amber : XColors.darkColor,
                        baseColor: XColors.grayColor,
                        child: IconButton(
                          onPressed: () => theme.setMode(!theme.isDarkMode),
                          icon: theme.isDarkMode
                              ? Icon(EvaIcons.sun)
                              : Icon(EvaIcons.moon),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: R.h(info, 2),
                    left: R.w(info, 4),
                    right: R.w(info, 4),
                  ),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      KText(
                        "Welcome\nBack",
                        googleFont: GoogleFonts.mavenPro(),
                        size: R.w(info, 10),
                        weight: FontWeight.bold,
                        color: theme.isDarkMode
                            ? XColors.darkGray
                            : XColors.darkColor.withOpacity(0.85),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/png/siting.png",
                            width: R.w(info, 75),
                          ),
                        ],
                      ),
                      Consumer(
                        builder: (context, watch, child) {
                          var mail = watch(mailProvider);
                          var pasa = watch(pasaProvider);
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: R.h(info, 7),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: R.w(info, 6)),
                                  child: TextField(
                                    controller: mail.mala,
                                    keyboardType: TextInputType.emailAddress,
                                    keyboardAppearance:
                                        Theme.of(context).brightness,
                                    style: TextStyle(
                                      fontSize: R.f(info, 14),
                                      color: theme.isDarkMode
                                          ? XColors.darkGray
                                          : XColors.darkColor.withOpacity(0.75),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "email",
                                      hintStyle: TextStyle(
                                        fontSize: R.f(info, 14),
                                        color: theme.isDarkMode
                                            ? XColors.darkGray.withOpacity(0.5)
                                            : XColors.darkColor
                                                .withOpacity(0.2),
                                      ),
                                      icon: Icon(EvaIcons.emailOutline),
                                      suffixIcon: Material(
                                        color: Colors.transparent,
                                        clipBehavior: Clip.antiAlias,
                                        borderRadius: BorderRadius.circular(
                                            R.w(info, 50)),
                                        child: isEmail(mail.mala.text)
                                            ? Icon(
                                                EvaIcons.checkmark,
                                                color: Colors.green,
                                              )
                                            : Icon(Ionicons.alert),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: R.h(info, 7),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: R.w(info, 6)),
                                  child: TextField(
                                    controller: pasa.pasa,
                                    obscureText: pasa.isHidden,
                                    obscuringCharacter: "*",
                                    keyboardType: TextInputType.visiblePassword,
                                    keyboardAppearance:
                                        Theme.of(context).brightness,
                                    style: TextStyle(
                                      fontSize: R.f(info, 14),
                                      color: theme.isDarkMode
                                          ? XColors.darkGray
                                          : XColors.darkColor.withOpacity(0.75),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "password",
                                      hintStyle: TextStyle(
                                        fontSize: R.f(info, 14),
                                        color: theme.isDarkMode
                                            ? XColors.darkGray.withOpacity(0.5)
                                            : XColors.darkColor
                                                .withOpacity(0.2),
                                      ),
                                      icon: Icon(EvaIcons.lockOutline),
                                      suffixIcon: Material(
                                        color: Colors.transparent,
                                        clipBehavior: Clip.antiAlias,
                                        borderRadius: BorderRadius.circular(
                                            R.w(info, 50)),
                                        child: InkWell(
                                          onTap: () =>
                                              pasa.toggleHide(!pasa.isHidden),
                                          child: pasa.isHidden
                                              ? Icon(EvaIcons.eyeOff2)
                                              : Icon(EvaIcons.eye),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: R.h(info, 5),
                                    bottom: R.h(info, 5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      pressed
                                          ? Center(
                                              child: CircularProgressIndicator(
                                              color: XColors.grayColor,
                                            ))
                                          : KClickable(
                                              width: R.w(info, 80),
                                              height: R.h(info, 7),
                                              onPressed: () async {
                                                setState(() {
                                                  pressed = true;
                                                });
                                                var sucess = await _signInCall(
                                                  context,
                                                  mail.mala,
                                                  pasa.pasa,
                                                );
                                                if (!sucess) {
                                                  context
                                                      .read(pasaProvider)
                                                      .pasa
                                                      .clear();
                                                  setState(() {
                                                    pressed = false;
                                                  });
                                                } else {
                                                  Future.delayed(Duration(
                                                          milliseconds: 1000))
                                                      .then((_) => Get.offAll(
                                                          () => Dashboard()));
                                                }
                                              },
                                              child: KText(
                                                "Login",
                                                weight: FontWeight.bold,
                                                color: theme.isDarkMode
                                                    ? XColors.darkColor
                                                    : Colors.white,
                                              ),
                                              topDeco: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    XColors.grayColor,
                                                    XColors.darkGray,
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              bottomDeco: BoxDecoration(
                                                color: theme.isDarkMode
                                                    ? XColors.darkColor2
                                                    : XColors.darkColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<bool> _signInCall(BuildContext context, TextEditingController _email,
      TextEditingController _pass) async {
    var sucess =
        await context.read(auth).signIn("gimhani@geeklibrary.com", "000000"
            // _email.text,
            // _pass.text,
            );
    if (sucess) {
      _email.clear();
      _pass.clear();
      Kui.toast("Login Sucessfull", textColor: Colors.green);
      return Future.delayed(Duration(milliseconds: 2000)).then((_) => true);
    } else {
      Kui.toast("Login Failed");
      return false;
    }
  }
}
