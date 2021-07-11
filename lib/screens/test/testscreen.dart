// import 'package:geekbooks/ads/adservice.dart';
// import 'package:geekbooks/constants/numers/nums.dart';
// import 'package:geekbooks/export/export.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   _TestScreenState createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: KText("AD Testing")),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               color: Colors.red,
//               height: 100,
//               padding: EdgeInsets.all(pad),
//               child: AdWidget(
//                 key: UniqueKey(),
//                 ad: AdService.createBannerAd()..load(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
