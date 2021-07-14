class MySettings {
  MySettings({this.isDarkMode});
  final bool? isDarkMode;
  factory MySettings.fromMap(Map<String, dynamic> json) =>
      MySettings(isDarkMode: json["isDarkMode"] ?? false);
  Map<String, dynamic> toMap() => {"isDarkMode": isDarkMode ?? false};
}
