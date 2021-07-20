import 'package:geeklibrary/packages/authentication/page/account/account_checkup.dart';
import 'package:geeklibrary/screens/welcome/welcome.dart';
import 'package:geeklibrary/widgets/kbuttons/kleaf_button.dart';
import 'package:lottie/lottie.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';

class VerificationCheck extends StatefulWidget {
  @override
  _VerificationCheckState createState() => _VerificationCheckState();
}

class _VerificationCheckState extends State<VerificationCheck>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ani;

  @override
  void initState() {
    _ani = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    _ani.dispose();
    super.dispose();
  }

  Future<bool> _emailVerified() async {
    User _user = FirebaseAuth.instance.currentUser!;
    await _user.reload();
    return _user.emailVerified;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Consumer(
            builder: (context, watch, child) {
              var isDarkMode = watch(themeProvider).isDarkMode;
              return Container(
                child: FutureBuilder<bool>(
                  future: _emailVerified(),
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Container();
                    } else {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (!snapshot.hasData) {
                        return Text("No Data Found");
                      } else if (snapshot.hasData) {
                        if (snapshot.data == true) {
                          return Lottie.asset(MyAssets.check,
                              repeat: false,
                              width: R.w(info, 35),
                              controller: _ani, onLoaded: (data) {
                            _ani.forward().whenComplete(() {
                              Get.offAll(() => AccountCheckup());
                            });
                          });
                        } else {
                          return Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Opacity(
                                    opacity: isDarkMode ? 0.1 : 0.5,
                                    child: Image.asset(
                                      "assets/images/shapes/main_top.png",
                                      width: R.w(info, 35),
                                      color: isDarkMode ? Colors.white30 : null,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Opacity(
                                    opacity: isDarkMode ? 0.1 : 0.5,
                                    child: Image.asset(
                                      "assets/images/shapes/login_bottom.png",
                                      width: R.w(info, 35),
                                      color: isDarkMode ? Colors.white30 : null,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(
                                    vertical: R.appbarHeight,
                                    horizontal: R.w(info, 5),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            KText(
                                              "Email is not verified",
                                              font: "MavenPro",
                                              weight: FontWeight.bold,
                                              textAlign: TextAlign.center,
                                              size: R.f(info, 20),
                                              color: Colors.redAccent[200],
                                            ),
                                            KText(
                                              "\nYou must verify email in order to proceed",
                                              font: "MavenPro",
                                              weight: FontWeight.bold,
                                              textAlign: TextAlign.center,
                                              size: R.f(info, 20),
                                              color: XColors.grayColor,
                                            ),
                                            KText(
                                              "\n\n\nrequest verification email",
                                              font: "Poppins",
                                              textAlign: TextAlign.center,
                                              size: R.f(info, 10),
                                              color: isDarkMode
                                                  ? Colors.greenAccent[200]
                                                  : Colors.green,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: R.h(info, 3)),
                                              child: KLeafButton(
                                                radius: 0,
                                                onPressed: () {
                                                  Get.off(
                                                      () => VerificationPage());
                                                },
                                                height: R.h(info, 7),
                                                width: R.w(info, 35),
                                                child: KText(
                                                  "verify",
                                                  font: "Poppins",
                                                  letterSpacing: 1.5,
                                                  weight: FontWeight.bold,
                                                  size: R.f(info, 10),
                                                  color: isDarkMode
                                                      ? XColors.grayColor
                                                      : XColors.lightColor1,
                                                ),
                                                icon: Ionicons
                                                    .mail_unread_outline,
                                                color1: isDarkMode
                                                    ? XColors.darkColor
                                                    : XColors.darkGray,
                                                color2: isDarkMode
                                                    ? XColors.grayColor
                                                    : XColors.lightColor1,
                                                iconColor: isDarkMode
                                                    ? XColors.darkColor
                                                    : XColors.darkGray,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: R.h(info, 10),
                                        margin:
                                            EdgeInsets.only(top: R.h(info, 5)),
                                        child: Column(
                                          children: [
                                            KText("Go back to welcome screen ?",
                                                size: R.f(info, 10),
                                                font: "Poppins"),
                                            SizedBox(height: R.h(info, 1)),
                                            OutlinedButton(
                                              onPressed: () async {
                                                await context
                                                    .read(auth)
                                                    .signOut()
                                                    .then((value) => Future
                                                            .delayed(Duration(
                                                                milliseconds:
                                                                    1500))
                                                        .then((_) => Get.off(() =>
                                                            WelcomeScreen())));
                                              },
                                              child: KText(
                                                "Go back",
                                                font: "Poppins",
                                                weight: FontWeight.bold,
                                                size: R.f(info, 10),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        return Text(snapshot.hashCode.toString());
                      }
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
