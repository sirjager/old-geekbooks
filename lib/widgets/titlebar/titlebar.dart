import 'package:geekbooks/export/export.dart';

class Titlebar extends StatelessWidget {
  const Titlebar(this.title, {Key? key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          KText(
            title,
            size: 15,
            color: Colors.white70,
            enableGoogleFonts: true,
            weight: FontWeight.bold,
            googleFont: GoogleFonts.poppins(),
          ),
        ],
      ),
    );
  }
}
