import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/titlebar/titlebar.dart';

class Settingspage extends StatelessWidget {
  final SizingInformation info;
  const Settingspage(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: R.w(info, 1),
        vertical: R.statusbarHeight(info),
      ),
      child: Column(
        children: [
          Titlebar(info),
          AppTitle(info, title: "Settings"),
          ProfileHeader(info),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;

  final String img =
      "https://avatars2.githubusercontent.com/u/15157788?v=4&s=460";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: R.h(info, 2)),
      child: Column(
        children: [
          Consumer(
            builder: (context, watch, child) {
              var theme = watch(themeProvider);
              return Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: R.w(info, 3),
                        left: R.w(info, 3),
                        right: R.w(info, 3),
                      ),
                      child: SvgPicture.asset(_avatar(9), fit: BoxFit.cover),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        gradient: G.purpleGradButtonDeco.gradient,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      bottom: R.w(info, 1),
                      right: R.w(info, 1),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, right: 3, left: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: KClickable(
                          onPressed: () =>
                              _chooseAvatar(context, theme.isDarkMode),
                          height: R.w(info, 9),
                          width: R.w(info, 9),
                          child: Icon(
                            EvaIcons.edit,
                            size: R.w(info, 5),
                            color: theme.isDarkMode
                                ? XColors.darkColor
                                : Colors.white,
                          ),
                          topDeco: BoxDecoration(
                            gradient: G.purpleGradButtonDeco.gradient,
                            shape: BoxShape.circle,
                          ),
                          bottomDeco: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.black]),
                            shape: BoxShape.circle,
                          ),
                        ),
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
  }

  String _avatar(int person) {
    return "assets/images/avatar/p${person.toString()}.svg";
  }

  void _chooseAvatar(BuildContext context, bool isDarkMode) {
    Get.dialog(
      Dialog(
        backgroundColor: isDarkMode ? XColors.darkColor : XColors.lightColor1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: R.h(info, 65),
          width: R.w(info, 75),
          padding: EdgeInsets.symmetric(
            vertical: R.w(info, 5),
            horizontal: R.w(info, 5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KText(
                "Choose Avatar",
                font: "MavenPro",
                size: R.f(info, 25),
                weight: FontWeight.bold,
                color: XColors.grayColor,
              ),
              SizedBox(height: R.h(info, 3)),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 12,
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    var avatar =
                        "assets/images/avatar/p" + index.toString() + ".svg";
                    return Container(
                      margin: EdgeInsets.all(R.w(info, 1)),
                      padding: EdgeInsets.only(
                        top: R.w(info, 2),
                        left: R.w(info, 2),
                        right: R.w(info, 2),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: SvgPicture.asset(avatar, fit: BoxFit.cover),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        gradient: G.purpleGradButtonDeco.gradient,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: R.h(info, 3)),
              Container(
                height: R.w(info, 13),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildGradient(G.redGradBannerDeco),
                    buildGradient(G.greenGradBannerDeco),
                    buildGradient(G.green2GradBannerDeco),
                    buildGradient(G.green3GradBannerDeco),
                    buildGradient(G.blueGradBannerDeco),
                    buildGradient(G.blue2GradBannerDeco),
                    buildGradient(G.pinkGradBannerDeco),
                    buildGradient(G.yellowGradBannerDeco),
                    buildGradient(G.purpleGradBannerDeco),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Container buildGradient(deco) {
    return Container(
      margin: EdgeInsets.all(5),
      width: R.w(info, 13),
      decoration: deco,
    );
  }
}
