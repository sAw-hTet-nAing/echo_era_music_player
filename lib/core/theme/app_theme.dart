import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade600,
      ));
}
