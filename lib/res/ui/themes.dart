import 'package:flutter/material.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';

class Themes {
  ThemeData darkMode() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      primaryColorDark: DesktopColors.grisSemiPalido,
      primaryColorLight: DesktopColors.grisPalido,
      dividerColor: DesktopColors.azulCielo,
    );
  }

  ThemeData lightMode() {
    return ThemeData(
      primaryColor: DesktopColors.prussianBlue,
      primaryColorDark: Colors.white,
      primaryColorLight: Colors.black87,
      dividerColor: DesktopColors.cerulean,
      scaffoldBackgroundColor: const Color.fromARGB(255, 238, 238, 238),
      cardColor: Colors.white,
      cardTheme: const CardThemeData(color: Colors.white),
    );
  }
}
