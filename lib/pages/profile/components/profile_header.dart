import 'package:geeklibrary/export/export.dart';

class AvatarSamples extends StatelessWidget {
  const AvatarSamples(this.info, {Key? key, required this.avatar})
      : super(key: key);
  final AvatarProvider avatar;
  final SizingInformation info;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: R.h(info, 7),
      child: ListView.builder(
        itemCount: 12,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          var _samples = "assets/images/avatar/p" + index.toString() + ".svg";
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: R.w(info, 1)),
            child: SizedBox(
              width: R.w(info, 15),
              height: R.w(info, 15),
              child: GestureDetector(
                onTap: () => avatar.setAvatar(index),
                child: Container(
                  margin: EdgeInsets.all(1),
                  decoration: avatar.avatar != index
                      ? null
                      : BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.greenAccent,
                        ),
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
            ),
          );
        },
      ),
    );
  }
}
