import 'package:geeklibrary/packages/authentication/page/account/account_checkup.dart';
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
          body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: R.w(info, 5)),
            child: FutureBuilder(
              future: _emailVerified(),
              builder: (context, AsyncSnapshot snapshot) {
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
                          Get.off(
                            () => AccountCheckup(),
                          );
                        });
                      });
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          ),
                          KText(
                            "\n\n\nrequest verification email",
                            font: "Poppins",
                            textAlign: TextAlign.center,
                            size: R.f(info, 10),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: R.h(info, 3)),
                            child: KLeafButton(
                              onPressed: () => Get.off(
                                () => VerificationPage(),
                              ),
                              height: R.h(info, 7),
                              width: R.w(info, 35),
                              child: KText(
                                "send email",
                                font: "Poppins",
                                weight: FontWeight.bold,
                                size: R.f(info, 10),
                              ),
                              icon: Ionicons.mail_unread_outline,
                            ),
                          ),
                        ],
                      );
                    }
                  } else {
                    return Text(snapshot.hashCode.toString());
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }
}
