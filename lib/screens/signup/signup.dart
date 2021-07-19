import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/screens/login/provider/login_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:string_validator/string_validator.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: R.appbarHeight),
            child: Column(
              children: <Widget>[
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
                          highlightColor: theme.isDarkMode
                              ? Colors.amber
                              : XColors.darkColor,
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
                        left: R.w(info, 4), right: R.w(info, 4)),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        KText(
                          "Create\nAccount",
                          font: "MavenPro",
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
                              "assets/images/png/signup.png",
                              width: R.w(info, 75),
                            ),
                          ],
                        ),
                        Consumer(
                          builder: (context, watch, child) {
                            var mail = watch(mailProvider);
                            var pasa = watch(pasaProvider);

                            return Column(
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
                                  margin: EdgeInsets.only(top: R.h(info, 5)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      KClickable(
                                        width: R.w(info, 80),
                                        height: R.h(info, 7),
                                        onPressed: () =>
                                            context.read(auth).signUp(
                                                  mail.mala.text,
                                                  pasa.pasa.text,
                                                ),
                                        child: KText(
                                          "Submit",
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
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
