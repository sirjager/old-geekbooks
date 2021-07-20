import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/titlebar/titlebar.dart';
import 'package:geeklibrary/pages/profile/components/nameplate.dart';
import 'package:geeklibrary/pages/profile/components/profile_header.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/left_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
              var avatar = watch(avatarProvider);
              String img =
                  "assets/images/avatar/p" + avatar.avatar.toString() + ".svg";
              return Container(
                margin: EdgeInsets.only(top: R.statusbarHeight(info)),
                child: Column(
                  children: <Widget>[
                    Titlebar(info),
                    AppTitle(info, title: "My Profile"),
                    Container(
                      padding: EdgeInsets.only(
                        top: R.w(info, 3),
                        left: R.w(info, 3),
                        right: R.w(info, 3),
                      ),
                      child: SvgPicture.asset(img, fit: BoxFit.cover),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        gradient: G.purpleGradButtonDeco.gradient,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: R.h(info, 2)),
                    AvatarSamples(info, avatar: avatar),
                    SizedBox(height: R.h(info, 2)),
                    NamePlate(info),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
