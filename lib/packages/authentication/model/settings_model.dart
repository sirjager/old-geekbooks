class MySettings {
  MySettings({required this.isDarkMode});
  final bool isDarkMode;
  factory MySettings.fromMap(Map<String, dynamic> json) => MySettings(
        isDarkMode: json["isDarkMode"],
      );
  Map<String, dynamic> toMap() => {"isDarkMode": isDarkMode};
}
