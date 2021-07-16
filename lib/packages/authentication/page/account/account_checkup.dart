import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/screens/account/disabled.dart';
import 'package:geeklibrary/screens/refresh/refresh.dart';
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
                                        return Lottie.asset(MyAssets.check,
                                            height: R.w(info, 35),
                                            repeat: false, onLoaded: (_) {
                                          _ani.forward().whenComplete(() {
                                            Get.off(
                                              () => RefreshApp(),
                                              transition: Transition.zoom,
                                            );
                                          });
                                        });
                                      } else {
                                        return Lottie.asset(MyAssets.cross,
                                            height: R.w(info, 35),
                                            repeat: false, onLoaded: (_) {
                                          _ani.forward().whenComplete(() {
                                            Get.off(
                                              () => AccountStatus(),
                                              transition: Transition.zoom,
                                            );
                                          });
                                        });
                                      }
                                    },
                                    loading: () => loadingWidget(),
                                    error: (e1, s1) => Text(e1.toString()),
                                  );
                                });
                              } else {
                                return Text(
                                  "Unable to create User Document in Database",
                                );
                              }
                            },
                            loading: () => loadingWidget(),
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
                                        return Lottie.asset(MyAssets.check,
                                            height: R.w(info, 35),
                                            repeat: false, onLoaded: (_) {
                                          _ani.forward().whenComplete(() {
                                            Get.off(
                                              () => RefreshApp(),
                                              transition: Transition.zoom,
                                            );
                                          });
                                        });
                                      } else {
                                        return Lottie.asset(MyAssets.cross,
                                            height: R.w(info, 35),
                                            repeat: false, onLoaded: (_) {
                                          _ani.forward().whenComplete(() {
                                            Get.off(
                                              () => AccountStatus(),
                                              transition: Transition.zoom,
                                            );
                                          });
                                        });
                                      }
                                    },
                                    loading: () => loadingWidget(),
                                    error: (e1, s1) => Text(e1.toString()),
                                  );
                                });
                              } else {
                                return Text(
                                    "Unable to update User Document in Database");
                              }
                            },
                            loading: () => loadingWidget(),
                            error: (e1, s1) => Text(e1.toString()),
                          );
                        },
                      );
                    }
                  },
                  loading: () => loadingWidget(),
                  error: (e1, s1) => Text(e1.toString()),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget loadingWidget() =>
      Lottie.asset(MyAssets.wave, height: (Get.height / 100) * 25);
}
