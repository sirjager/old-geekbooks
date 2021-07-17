class DrawerProperties {
  bool isDarkMode;

  DrawerProperties({required this.isDarkMode});

  DrawerProperties copyWith({bool? isDarkMode}) => DrawerProperties(
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
