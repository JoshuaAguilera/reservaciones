import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';

class Themes {
  ThemeData darkMode() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: false,
      primaryColor: Colors.white,
      primaryColorDark: DesktopColors.grisSemiPalido,
      primaryColorLight: DesktopColors.grisPalido,
    );
  }

  ThemeData lightMode() {
    return ThemeData(
      useMaterial3: false,
      primaryColor: DesktopColors.prussianBlue,
      primaryColorDark: Colors.white,
      primaryColorLight: Colors.black87,
    );
  }
}
