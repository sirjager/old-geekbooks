import 'dart:async';

import 'package:geekbooks/bundles/authentication/dialog/dialog.dart';
import 'package:geekbooks/bundles/authentication/export/export.dart';
import 'package:geekbooks/export/export.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final User _user = FirebaseAuth.instance.currentUser!;
  late Timer timer;
  late final SizingInformation _info;
  @override
  void initState() {
    _info = context.read(infoProvider).info;
    timer = Timer.periodic(Duration(seconds: 5), (val) {
      checkEmailVerified(_user, _info);
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<bool> checkEmailVerified(User user, SizingInformation info) async {
    bool _isVerified = user.emailVerified;
    if (_isVerified) {
      return true;
    } else {
      user.reload();
      user.sendEmailVerification();
      if (user.emailVerified) {
        timer.cancel();
        Get.off(() => Dashboard());
      }
      AuthDialog.showDialog(context);
    }

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      user.reload();
      if (user.emailVerified) {
        _isVerified = user.emailVerified;
        timer.cancel();
      } else {
        _isVerified = user.emailVerified;
      }
    });
    timer.cancel();
    print(_isVerified);
    return _isVerified;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
