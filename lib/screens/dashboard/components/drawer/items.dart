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
