import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/packages/authentication/functions/firestore_operations.dart';
import 'package:geeklibrary/screens/account/disabled.dart';
import 'package:geeklibrary/screens/login/provider/login_provider.dart';
import 'package:lottie/lottie.dart';

class AccountCheckup extends StatefulWidget {
  @override
  _AccountCheckupState createState() => _AccountCheckupState();
}

class _AccountCheckupState extends State<AccountCheckup>
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

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Center(
            child: Consumer(
              builder: (context, watch, child) {
                final isNewUser = watch(isNewUserPro);
                return isNewUser.when(
                  data: (isNew) {
                    if (isNew) {
                      //* Create User Document for this new user
                      return Consumer(builder: (context, watch, child) {
                        var _created = watch(createAccountPro);
                        return _created.when(
                          data: (created) {
                            if (created) {
                              return Consumer(
                                  builder: (context, watch3, child3) {
                                final _userDoc = watch3(getAccountPro);
                                return _userDoc.when(
                                  data: (_acc) {
                                    if (_acc.isAccountEnabled) {
                                      return enabledWidget(info, _acc);
                                    } else {
                                      return Lottie.asset(MyAssets.cross,
                                          height: R.w(info, 35),
                                          repeat: false, onLoaded: (_) {
                                        _ani.forward().whenComplete(() {
                                          Get.offAll(() => AccountStatus(),
                                              transition: Transition.fadeIn);
                                        });
                                      });
                                    }
                                  },
                                  loading: () => Container(),
                                  error: (e1, s1) => Text(e1.toString()),
                                );
                              });
                            } else {
                              return Text("Unable To Create Account");
                            }
                          },
                          loading: () => Container(),
                          error: (e1, s1) => Text(e1.toString()),
                        );
                      });
                    } else {
                      return Consumer(builder: (context, watch3, child3) {
                        final _userDoc = watch3(getAccountPro);
                        return _userDoc.when(
                          data: (_acc) {
                            if (_acc.isAccountEnabled) {
                              return enabledWidget(info, _acc);
                            } else {
                              return Lottie.asset(MyAssets.cross,
                                  height: R.w(info, 35),
                                  repeat: false, onLoaded: (_) {
                                _ani.forward().whenComplete(() {
                                  Get.off(
                                      () => AccountStatus(
                                          msg: _acc.accountStatus),
                                      transition: Transition.fadeIn);
                                });
                              });
                            }
                          },
                          loading: () => Container(),
                          error: (e1, s1) => Text(e1.toString()),
                        );
                      });
                    }
                  },
                  loading: () => Container(),
                  error: (e1, s1) => Text(e1.toString()),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget enabledWidget(SizingInformation info, AccountDetails _account) {
    return Lottie.asset(MyAssets.check,
        controller: _ani, height: R.w(info, 25), repeat: false, onLoaded: (_) {
      context.read(themeProvider).setMode(_account.isDarkThemeEnabled);
      _ani.forward().whenComplete(() {
        Get.offAll(() => Dashboard(), transition: Transition.fadeIn);
      });
    });
  }

  late final createAccountPro = FutureProvider<bool>((ref) async {
    final User _user = FirebaseAuth.instance.currentUser!;
    final bool isDarkMode = context.read(themeProvider).isDarkMode;
    final String name = context.read(nameProvider).name.text;
    final user = AccountDetails.build(_user);
    final _acc = user.copyWith(name: name, isDarkThemeEnabled: isDarkMode);
    return await FirestoreOperations.saveAccountDetails(_user, _acc);
  });
}
