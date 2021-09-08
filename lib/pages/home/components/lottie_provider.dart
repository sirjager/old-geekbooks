import 'package:geeklibrary/export/export.dart';

class KLottieProvider {
  static final lottieProvider =
      ChangeNotifierProvider((_) => LottieAnimationProvider());
}

class LottieAnimationProvider extends ChangeNotifier {
  bool _animate = false;
  bool get animate => _animate;
  void play({int sec = 5}) async {
    try {
      _animate = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: sec));
      _animate = false;
      notifyListeners();
    } catch (e) {}
  }
}
