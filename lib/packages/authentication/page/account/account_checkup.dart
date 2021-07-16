import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/screens/account/disabled.dart';
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
                      return Consumer(
                        builder: (context, watch2, child2) {
                          final created = watch2(createAccountPro);
                          return created.when(
                            data: (_created) {
                              if (_created) {
                                return Consumer(
                                    builder: (context, watch3, child3) {
                                  final _userDoc = watch3(getAccountPro);
                                  return _userDoc.when(
                                    data: (_acc) {
                                      if (_acc.isAccountEnabled) {
                                        return enabledWidget(info);
                                      } else {
                                        return Lottie.asset(MyAssets.cross,
                                            height: R.w(info, 35),
                                            repeat: false, onLoaded: (_) {
                                          _ani.forward().whenComplete(() {
                                            Get.off(() => AccountStatus(),
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
                                return Text(
                                  "Unable to create User Document in Database",
                                );
                              }
                            },
                            loading: () => Container(),
                            error: (e1, s1) => Text(e1.toString()),
                          );
                        },
                      );
                    } else {
                      return Consumer(
                        builder: (context, watch2, child2) {
                          final updated = watch2(updateAccountPro);
                          return updated.when(
                            data: (_updated) {
                              if (_updated) {
                                return Consumer(
                                    builder: (context, watch3, child3) {
                                  final _userDoc = watch3(getAccountPro);
                                  return _userDoc.when(
                                    data: (_acc) {
                                      if (_acc.isAccountEnabled) {
                                        return enabledWidget(info);
                                      } else {
                                        return Lottie.asset(MyAssets.cross,
                                            height: R.w(info, 35),
                                            repeat: false, onLoaded: (_) {
                                          _ani.forward().whenComplete(() {
                                            Get.off(() => AccountStatus(),
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
                                return Text(
                                    "Unable to update User Document in Database");
                              }
                            },
                            loading: () => Container(),
                            error: (e1, s1) => Text(e1.toString()),
                          );
                        },
                      );
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

  Consumer enabledWidget(SizingInformation info) {
    return Consumer(
      builder: (context, watch4, child4) {
        var _acc = watch4(initializeAccountPro);
        return _acc.when(
          data: (_account) {
            return Lottie.asset(MyAssets.check,
                controller: _ani,
                height: R.w(info, 25),
                repeat: false, onLoaded: (_) {
              context.read(themeProvider).setMode(_account.isDarkThemeEnabled);
              _ani.forward().whenComplete(() {
                Get.off(() => Dashboard(), transition: Transition.fadeIn);
              });
            });
          },
          loading: () => Container(),
          error: (e, s) => Text(e.toString()),
        );
      },
    );
  }

  // Widget loadingWidget() =>
  //     Lottie.asset(MyAssets.wave, height: (Get.height / 100) * 25);
}
