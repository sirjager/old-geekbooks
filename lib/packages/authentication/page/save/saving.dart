// import 'package:geeklibrary/bundles/authentication/export/export.dart';
// import 'package:geeklibrary/bundles/authentication/functions/authentication_fnx.dart';
// import 'package:geeklibrary/export/export.dart';
// import 'package:lottie/lottie.dart';

// class LoadUserPage extends StatelessWidget {
//   final UserOption options = UserOption();
//   final User _user = FirebaseAuth.instance.currentUser!;

//   Future<Person> loadUser() async {
//     await options.checkUser(_user);
//     final person = await options.getUserDetails(_user.uid);
//     return person;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ResponsiveBuilder(
//         builder: (context, info) {
//           return Container(
//             alignment: Alignment.center,
//             child: FutureBuilder<Person>(
//               future: loadUser(),
//               builder: (BuildContext context, AsyncSnapshot<Person> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Lottie.asset(MyAssets.wave, height: R.w(info, 35)),
//                       Container(
//                         margin: EdgeInsets.only(top: R.h(info, 3)),
//                         child: KText("Please wait while Loading details",
//                             font: "MavenPro", textAlign: TextAlign.center),
//                       ),
//                     ],
//                   );
//                 } else if (snapshot.connectionState == ConnectionState.done) {
//                   if (!snapshot.hasData) {
//                     return Text("User Data Not Found");
//                   } else if (snapshot.hasError) {
//                     return Text(
//                         "Error while fetching data : ${snapshot.error.toString()}");
//                   } else if (snapshot.hasData) {
//                     final person = snapshot.data!;
//                     return Text(person.email.toString());
//                   } else {
//                     return Text("Something went wrong");
//                   }
//                 } else
//                   return Container();
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
