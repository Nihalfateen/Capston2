import 'package:capstone/core/theme/style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    primarySwatch: primarySwatchColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: whiteColor,
    fontFamily: "Schyler",
    scrollbarTheme: ScrollbarThemeData(
      interactive: true,
      thickness: MaterialStateProperty.all(5.0),
      thumbColor: MaterialStateProperty.all(primaryColor.withOpacity(0.4)),
    ),
    highlightColor: primaryColor,
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: primaryColor),
  );
}
