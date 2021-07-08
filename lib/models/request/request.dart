import 'package:hive/hive.dart';
part 'request.g.dart';

@HiveType(typeId: 0)
class KRequest extends HiveObject {
  KRequest({
    required this.url,
    required this.response,
  });
  @HiveField(0)
  final String url;
  @HiveField(1)
  final dynamic response;
}
