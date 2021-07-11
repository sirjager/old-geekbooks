import 'package:geekbooks/export/export.dart';

class Poster extends StatelessWidget {
  const Poster(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: R.h(info, 45),
      width: double.infinity,
      
    );
  }
}
