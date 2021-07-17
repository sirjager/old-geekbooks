import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/titlebar/titlebar.dart';
import 'package:geeklibrary/pages/results/components/header.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';

class RiderProvider extends StatelessWidget {
  const RiderProvider(this.book, {Key? key}) : super(key: key);
  final Book book;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.only(top: R.statusbarHeight(info)),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: PageHeader(info,
                        title: book.title!, disableAction: true)),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.all(R.w(info, 5)),
                            child: KImage(
                              width: R.w(info, 50),
                              height: R.w(info, 80),
                              imageURL: book.coverURL,
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          SizedBox(
                            width: R.w(info, 80),
                            child: KText(
                              book.title!,
                              font: "MavenPro",
                              size: R.f(info, 20),
                              weight: FontWeight.bold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: R.w(info, 5),
                              vertical: R.h(info, 1),
                            ),
                            child: KText(
                              book.fileSize.toString(),
                            ),
                          ),
                          Container(
                            height: R.h(info, 15),
                            margin: EdgeInsets.symmetric(
                              horizontal: R.w(info, 5),
                              vertical: R.h(info, 1),
                            ),
                            color: Colors.red[100],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                KClickable(
                                  onPressed: () {},
                                  child: KText("go to download page"),
                                  topDeco: G.greenGradBannerDeco,
                                ),
                                KClickable(
                                  onPressed: () {},
                                  width: R.w(info, 20),
                                  child: Text("data"),
                                  topDeco: G.greenGradBannerDeco,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
