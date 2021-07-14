import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:geeklibrary/bundles/authentication/export/export.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/widgets/kbuttons/kleaf_button.dart';

class Settingspage extends StatelessWidget {
  final SizingInformation info;
  const Settingspage(this.info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.orange[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Settings page",
          ),
          SizedBox(height: R.h(info, 10)),
          KLeafButton(
            height: R.h(info, 10),
            onPressed: () async {
              await context.read(auth).signOut();
              Phoenix.rebirth(context);
            },
            child: KText(
              'Go back',
              size: R.f(info, 12),
              weight: FontWeight.w500,
              textDecoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
