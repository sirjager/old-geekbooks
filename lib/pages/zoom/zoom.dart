import 'package:cached_network_image/cached_network_image.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/pages/results/components/header.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

class ZoomView extends StatelessWidget {
  const ZoomView({Key? key, required this.img, required this.tag})
      : super(key: key);
  final String? img;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 90.h),
        child: Column(
          children: [
            ResultHeader(title: "Go Back"),
            Expanded(
              child: Hero(
                tag: tag,
                child: CachedNetworkImage(
                  imageUrl: img ?? "",
                  imageBuilder: (context, imageProvider) => PhotoView(
                    imageProvider: imageProvider,
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor:
                        Get.isDarkMode ? XColors.grayText : Colors.grey[200]!,
                    highlightColor:
                        Get.isDarkMode ? XColors.lightGray : Colors.white,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/png/noimage.png"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
