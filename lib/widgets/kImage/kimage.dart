import 'package:cached_network_image/cached_network_image.dart';
import 'package:geekbooks/export/export.dart';

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
    this.radius = 0.0,
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
  final double radius;
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
          borderRadius: BorderRadius.circular(radius),
          border: border,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
            colorFilter:
                ColorFilter.mode(filterColor, blendMode ?? BlendMode.color),
          ),
        ),
      ),
      placeholder: (context, url) =>
          Center(child: CircularProgressIndicator.adaptive()),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
            fit: fit,
            colorFilter:
                ColorFilter.mode(filterColor, blendMode ?? BlendMode.color),
            image: AssetImage(
              "",
            ),
          ),
        ),
      ),
    );
  }
}
