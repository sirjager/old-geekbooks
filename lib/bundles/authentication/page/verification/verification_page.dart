import 'package:geekbooks/export/export.dart';
import 'package:lottie/lottie.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool _verificationRequested = false;
  bool _sentPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _verifyUser() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, info) {
          if (!_verificationRequested) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: R.h(info, 2)),
                    child: _sentPressed
                        ? Container(
                            child: Text(
                              "sent Button Pressed",
                            ),
                          )
                        : OutlinedButton(
                            onPressed: () =>
                                setState(() => _sentPressed = false),
                            child: Padding(
                              padding: EdgeInsets.all(R.w(info, 5)),
                              child: KText(
                                "send veification email",
                                font: "MavenPro",
                                size: R.f(info, 15),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            );
          }
          return FutureBuilder(
            future: _verifyUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  bool _verified = snapshot.data;
                  if (_verified) {
                  } else {
                    return Container(
                        alignment: Alignment.center, child: Text("Done"));
                  }
                }
              }
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      MyAssets.checkmail,
                      height: R.h(info, 35),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: R.h(info, 2),
                      ),
                      child: KText(
                        "check your inbox",
                        font: "MavenPro",
                        size: R.f(info, 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: R.w(info, 10),
                        right: R.w(info, 10),
                        bottom: R.h(info, 10),
                      ),
                      child: KText(
                        "We have sent verification link to your email",
                        font: "MavenPro",
                        size: R.f(info, 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
