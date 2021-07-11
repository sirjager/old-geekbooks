import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/widgets/kImage/kimage.dart';

class BookRow extends StatelessWidget {
  const BookRow(this.info,
      {Key? key, required this.result, required this.notIncludeID})
      : super(key: key);
  final List result;
  final String notIncludeID;
  final SizingInformation info;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: R.h(info, 29),
      width: double.infinity,
      child: ListView.builder(
        itemCount: result.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var b = result[index];
          if (b.id != notIncludeID) {
            return Padding(
              padding: const EdgeInsets.all(pad),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.red,
                  highlightColor: Colors.red,
                  onTap: () => Get.to(() => BookView(book: b, books: result)),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      margin: const EdgeInsets.all(pad / 2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: pad,
                          color: Colors.black,
                        ),
                      ),
                      width: R.w(info, 37),
                      child: KImage(fit: BoxFit.fill, imageURL: b.coverURL!),
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
