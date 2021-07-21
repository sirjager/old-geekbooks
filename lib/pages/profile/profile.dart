import 'package:geeklibrary/core/dialog/dialogs.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/titlebar/titlebar.dart';
import 'package:geeklibrary/packages/authentication/export/export.dart';
import 'package:geeklibrary/packages/authentication/functions/firestore_operations.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/left_drawer.dart';
import 'package:geeklibrary/screens/login/provider/login_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editAvatar = false;
  bool editName = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          drawer: LeftDrawer(info),
          endDrawer: RightDrawer(info),
          body: Consumer(
            builder: (context, watch, child) {
              var isDarkMode = watch(themeProvider).isDarkMode;
              var ac = watch(accountProvider);
              watch(nameProvider).setname(ac.account.name.toString());
              var nameController = watch(nameProvider).name;
              var avatar = watch(avatarProvider);
              return Container(
                margin: EdgeInsets.only(top: R.statusbarHeight(info)),
                child: Column(
                  children: <Widget>[
                    Titlebar(info),
                    AppTitle(info, title: "My Profile"),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Consumer(
                          builder: (context, watch, child) {
                            int gindex = watch(avatarProvider).avatarGradient;
                            return Container(
                              padding: EdgeInsets.only(
                                top: R.w(info, 3),
                                left: R.w(info, 3),
                                right: R.w(info, 3),
                              ),
                              child: SvgPicture.asset(
                                "assets/images/avatar/p" +
                                    avatar.avatar.toString() +
                                    ".svg",
                                fit: BoxFit.cover,
                              ),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                gradient: XGradient.gradient[gindex],
                                shape: BoxShape.circle,
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: R.w(info, 3),
                          right: R.w(info, 3),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              shape: BoxShape.circle,
                            ),
                            margin: EdgeInsets.all(1),
                            padding: EdgeInsets.all(2),
                            child: KClickable(
                              width: R.w(info, 7),
                              height: R.w(info, 7),
                              onPressed: () {
                                setState(() {
                                  editAvatar = !editAvatar;
                                });
                                __avatarSelector(info, ac.account);
                              },
                              child: Icon(
                                editAvatar
                                    ? EvaIcons.checkmark
                                    : EvaIcons.editOutline,
                                size: R.w(info, 4),
                              ),
                              topDeco: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                              bottomDeco: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: R.h(info, 2)),
                    Consumer(
                      builder: (context, watch, child) {
                        var _name = watch(nameProvider);
                        return Container(
                          height: R.h(info, 10),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: R.w(info, 5)),
                                width: R.w(info, 75),
                                child: Container(
                                  child: TextField(
                                    readOnly: !editName,
                                    keyboardType: TextInputType.emailAddress,
                                    keyboardAppearance:
                                        Theme.of(context).brightness,
                                    onChanged: (value) => _name.setname(value),
                                    style: TextStyle(
                                      fontSize: R.f(info, 14),
                                      color: isDarkMode
                                          ? XColors.darkGray
                                          : XColors.darkColor.withOpacity(0.75),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: ac.account.name,
                                      hintStyle: TextStyle(
                                        fontSize: R.f(info, 14),
                                        color: isDarkMode
                                            ? XColors.darkGray.withOpacity(0.5)
                                            : XColors.darkColor
                                                .withOpacity(0.2),
                                      ),
                                      icon: Icon(Typicons.user_outline),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: R.w(info, 5)),
                                child: KClickable(
                                  onPressed: () async {
                                    // setState(() => editName = !editName);

                                    _showEditName(info, nameController);

                                    // if (!editName) {
                                    //   var saved = await FirestoreOperations.saveAccountDetails(
                                    //     ac.account.uid,
                                    //     ac.account.copyWith(name: _name.name.text),
                                    //   );
                                    //   if (!saved) {
                                    //     Kui().toast(context, "Unable to save try again later");
                                    //   }
                                    // }
                                  },
                                  width: R.w(info, 10),
                                  height: R.w(info, 10),
                                  child: Icon(
                                    !editName
                                        ? EvaIcons.edit
                                        : EvaIcons.checkmark,
                                    size: R.f(info, 15),
                                  ),
                                  topDeco: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        XColors.grayColor,
                                        XColors.grayColor
                                      ]),
                                      borderRadius: BorderRadius.circular(10)),
                                  bottomDeco: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [Colors.black, Colors.black]),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void __avatarSelector(SizingInformation info, AccountDetails ac) async {
    var avatar = context.read(avatarProvider);
    await Get.bottomSheet(
      Container(
        margin: EdgeInsets.symmetric(vertical: R.h(info, 5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemCount: 12,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                var _samples =
                    "assets/images/avatar/p" + index.toString() + ".svg";
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: R.w(info, 1)),
                  child: SizedBox(
                    width: R.w(info, 15),
                    height: R.w(info, 15),
                    child: GestureDetector(
                      onTap: () async {
                        var saved =
                            await FirestoreOperations.saveAccountDetails(
                          ac.uid,
                          ac.copyWith(
                              image: avatar.avatar.toString() +
                                  "+" +
                                  avatar.avatarGradient.toString()),
                        );
                        if (!saved) {
                          Kui().toast(context, "Avatar Save Failded");
                        }
                        setState(() {
                          avatar.setAvatar(index);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(R.w(info, 1)),
                        padding: EdgeInsets.only(
                          top: R.w(info, 2),
                          left: R.w(info, 1),
                          right: R.w(info, 1),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: SvgPicture.asset(_samples, fit: BoxFit.contain),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          gradient: G.purpleGradButtonDeco.gradient,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(
                top: R.h(info, 2),
              ),
              height: R.h(info, 10),
              child: ListView.builder(
                itemCount: XGradient.gradient.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: R.w(info, 1)),
                    child: SizedBox(
                      width: R.w(info, 15),
                      height: R.w(info, 15),
                      child: GestureDetector(
                        onTap: () async {
                          var saved =
                              await FirestoreOperations.saveAccountDetails(
                            ac.uid,
                            ac.copyWith(
                                image: avatar.avatar.toString() +
                                    "+" +
                                    avatar.avatarGradient.toString()),
                          );
                          if (!saved) {
                            Kui().toast(context, "Avatar Save Failded");
                          }
                          setState(() {
                            avatar.setAvatarGradient(index);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(R.w(info, 1)),
                          padding: EdgeInsets.only(
                            top: R.w(info, 2),
                            left: R.w(info, 1),
                            right: R.w(info, 1),
                          ),
                          alignment: Alignment.bottomCenter,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              gradient: XGradient.gradient[index],
                              shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
    );
  }

  void _showEditName(
      SizingInformation info, TextEditingController _controller) async {
    await Get.bottomSheet(
      Container(
        height: R.h(info, 10),
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          horizontal: R.w(info, 5),
          vertical: R.w(info, 5),
        ),
        child: TextField(
          autofocus: true,
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          keyboardAppearance: Get.theme.brightness,
          style: TextStyle(
            fontSize: R.f(info, 14),
            color: Get.isDarkMode
                ? XColors.darkGray
                : XColors.darkColor.withOpacity(0.75),
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: R.f(info, 14),
              color: Get.isDarkMode
                  ? XColors.darkGray.withOpacity(0.5)
                  : XColors.darkColor.withOpacity(0.2),
            ),
            icon: Icon(Typicons.user_outline),
          ),
        ),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    );
  }
}
