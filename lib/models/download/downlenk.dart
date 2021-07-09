import 'package:geekbooks/models/lenk/lenk.dart';
import 'package:hive/hive.dart';
part 'downlenk.g.dart';

@HiveType(typeId: 2)
class DownLenks extends HiveObject {
  DownLenks({
    required this.id,
    required this.md5,
    required this.get,
    required this.cfa,
    required this.ips,
    required this.inf,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String md5;
  @HiveField(2)
  final String get;
  @HiveField(3)
  final String cfa;
  @HiveField(4)
  final String ips;
  @HiveField(5)
  final String inf;

  factory DownLenks.generate(String id, String md5, List<Lenk> _lenk) =>
      DownLenks(
        id: id,
        md5: md5,
        get: _lenk[0].lenk,
        cfa: _lenk[1].lenk,
        ips: _lenk[2].lenk,
        inf: _lenk[3].lenk,
      );
}
