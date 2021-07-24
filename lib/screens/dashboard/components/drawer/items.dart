import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/pages/sabed/sabed.dart';

class KDMI {
  static final List<Dmi> items = [
    Dmi(
      index: 0,
      onTap: () => Get.offAll(() => Dashboard()),
      title: 'Search',
      icon: EvaIcons.searchOutline,
    ),
    Dmi(
      index: 1,
      onTap: () => Get.to(() => SabedOffline()),
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
