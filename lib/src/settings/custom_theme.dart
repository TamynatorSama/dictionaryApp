import 'package:flutter/material.dart';

CustomTheme customTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool isDarkTheme = false;
  ThemeMode get currentTheme => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  static String presentFontFamily = "Inter";

  String get fontFamily {
    switch (presentFontFamily) {
      case "Inter":
        return "San Serif";
      case "Lora":
        return "Serif";
      case "Inconsolata":
        return "Mono";
      default:
        return "San Serif";
    }
  }

  void changeFontFamily(FontFamilyName familyName) {
    switch (familyName) {
      case FontFamilyName.inter:
        presentFontFamily = "Inter";
        break;
      case FontFamilyName.lora:
        presentFontFamily = "Lora";
        break;
      case FontFamilyName.inconsolata:
        presentFontFamily = "Inconsolata";
        break;
    }
    notifyListeners();
  }

  void toggle() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme => ThemeData(
      primaryColor: const Color(0xffA445ED),
      popupMenuTheme: PopupMenuThemeData(
          color: Colors.white, shadowColor: Colors.grey.withOpacity(0.2)),
      primaryColorDark: const Color(0xff757575),
      scaffoldBackgroundColor: Colors.white,
      shadowColor: const Color(0x61A445ED),
      textTheme: const TextTheme().copyWith(
        headlineLarge: TextStyle(
              fontFamily: presentFontFamily,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xff2d2d2d)),
        headlineSmall: TextStyle(
              fontFamily: presentFontFamily,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: const Color(0xff2d2d2d)),
          displayMedium: TextStyle(
              fontFamily: presentFontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xff2d2d2d)),
          bodySmall: TextStyle(
              fontFamily: presentFontFamily,
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: const Color(0xff2d2d2d)),
          bodyMedium: TextStyle(
              fontFamily: presentFontFamily,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xff2d2d2d))));

  static ThemeData get darkTheme => ThemeData(
      primaryColor: const Color(0xffA445ED),
      primaryColorDark: const Color(0xffA445ED),
      scaffoldBackgroundColor: Colors.black,
      shadowColor: const Color(0x61A445ED),
      popupMenuTheme: PopupMenuThemeData(
          color: const Color(0xff1f1f1f),
          shadowColor: const Color(0xffA445ED).withOpacity(0.3)),
      textTheme: const TextTheme().copyWith(
        headlineLarge: TextStyle(
              fontFamily: presentFontFamily,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        headlineSmall: TextStyle(
              fontFamily: presentFontFamily,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white),
          displayMedium: TextStyle(
              fontFamily: presentFontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white),
              bodySmall: TextStyle(
              fontFamily: presentFontFamily,
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.white),
          bodyMedium: TextStyle(
              fontFamily: presentFontFamily,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white)));
}

enum FontFamilyName { inter, lora, inconsolata }
