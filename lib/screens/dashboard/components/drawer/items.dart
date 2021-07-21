import 'package:geeklibrary/export/export.dart';

class KDMI {
  static final List<Dmi> items = [
    Dmi(
      index: 0,
      onTap: () {},
      title: 'Search',
      icon: EvaIcons.searchOutline,
    ),
    Dmi(
      index: 1,
      onTap: () {},
      title: 'Offline',
      icon: EvaIcons.downloadOutline,
    ),
    // Dmi(
    //   index: 2,
    //   onTap: () {},
    //   title: 'App Info',
    //   icon: EvaIcons.infoOutline,
    // ),
    // Dmi(
    //   index: 3,
    //   onTap: () {},
    //   title: 'Contact Us',
    //   icon: EvaIcons.peopleOutline,
    // ),
    // Dmi(
    //   index: 4,
    //   onTap: () {},
    //   title: 'Help Center',
    //   icon: EvaIcons.questionMarkCircleOutline,
    // ),
    // Dmi(
    //   index: 5,
    //   onTap: () {},
    //   title: 'Privacy Policy',
    //   icon: EvaIcons.fileOutline,
    // ),
  ];
}

class Dmi {
  final int index;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  Dmi({
    required this.index,
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
