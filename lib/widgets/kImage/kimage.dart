import 'package:cached_network_image/cached_network_image.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:shimmer/shimmer.dart';

class KImage extends StatelessWidget {
  const KImage({
    Key? key,
    required this.imageURL,
    this.imagePATH = "",
    this.height = 100.0,
    this.width = 50.0,
    this.fit = BoxFit.cover,
    this.blendMode,
    this.filterQuality = FilterQuality.medium,
    this.filterColor = Colors.transparent,
    this.repeat = ImageRepeat.noRepeat,
    this.borderRadius,
    this.border,
 
  
  }) : super(key: key);
  final String? imageURL;
  final String? imagePATH;
  final double? height;
  final double? width;
  final BoxFit fit;
  final FilterQuality filterQuality;
  final BlendMode? blendMode;
  final Color filterColor;
  final ImageRepeat repeat;
  final BorderRadius? borderRadius;
  final BoxBorder? border;


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      repeat: repeat,
      height: height,
      width: width,
      fit: fit,
      imageUrl: imageURL ?? "",
      filterQuality: filterQuality,
      colorBlendMode: blendMode,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: border,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
            colorFilter:
                ColorFilter.mode(filterColor, blendMode ?? BlendMode.color),
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Get.isDarkMode ? XColors.grayText : Colors.grey[200]!,
        highlightColor: Get.isDarkMode ? XColors.lightGray : Colors.white,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: Colors.white, borderRadius: borderRadius),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            fit: fit,
            colorFilter:
                ColorFilter.mode(filterColor, blendMode ?? BlendMode.color),
            image: AssetImage("assets/images/png/noimage.png"),
          ),
        ),
      ),
    );
  }
}
