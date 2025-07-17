import 'package:flutter/material.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';

import '../helpers/colors_helpers.dart';
import 'text_styles.dart';

class Themes {
  ThemeData darkMode() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      primaryColorDark: DesktopColors.grisSemiPalido,
      primaryColorLight: DesktopColors.grisPalido,
      dividerColor: DesktopColors.azulCielo,
      textTheme: TextTheme(
        bodyMedium: TextStyles.styleStandar(color: Colors.white),
        displayMedium: TextStyles.styleStandar(color: Colors.white),
        labelMedium: TextStyles.styleStandar(color: Colors.white),
        headlineMedium: TextStyles.styleStandar(color: Colors.white),
        titleMedium: TextStyles.styleStandar(color: Colors.white),
        titleLarge: TextStyles.styleStandar(color: Colors.white),
        bodyLarge: TextStyles.styleStandar(color: Colors.white),
        titleSmall: TextStyles.styleStandar(color: Colors.white, size: 13),
        bodySmall: TextStyles.styleStandar(color: Colors.white, size: 10),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.2, color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        iconColor: Colors.white,
        suffixIconColor: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
      ),
      // canvasColor: DesktopColors.backgroudColor,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(DesktopColors.azulUltClaro),
          foregroundColor: WidgetStatePropertyAll(DesktopColors.azulUltClaro),
          textStyle: WidgetStatePropertyAll(
            TextStyles.styleStandar(),
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(closeIconColor: Colors.white),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyles.titleTextStyle(
          isBold: true,
          size: 18,
          color: Colors.white,
        ),
        backgroundColor: ColorsHelpers.darken(DesktopColors.canvasColor, 0.1),
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.white,
      ),
    );
  }

  ThemeData lightMode() {
    return ThemeData(
      useMaterial3: true,
      primaryColor: DesktopColors.prussianBlue,
      primaryColorDark: Colors.white,
      primaryColorLight: Colors.black87,
      dividerColor: DesktopColors.cerulean,
      iconTheme: const IconThemeData(color: Colors.black87),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(
            Colors.black87,
          ),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color.fromARGB(255, 238, 238, 238),
      cardTheme: const CardThemeData(
        color: Color.fromARGB(255, 238, 238, 238),
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyles.styleStandar(color: Colors.black87),
        displayMedium: TextStyles.styleStandar(color: Colors.black87),
        labelMedium: TextStyles.styleStandar(color: Colors.black87),
        headlineMedium: TextStyles.styleStandar(color: Colors.black87),
        titleMedium: TextStyles.styleStandar(color: Colors.black87),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(DesktopColors.cerulean),
          foregroundColor: WidgetStatePropertyAll(DesktopColors.cerulean),
          textStyle: WidgetStatePropertyAll(
            TextStyles.styleStandar(isBold: true),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyles.titleTextStyle(
          isBold: true,
          size: 18,
          color: Colors.white,
        ),
        backgroundColor: DesktopColors.canvasColor,
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.white,
      ),
      snackBarTheme: const SnackBarThemeData(closeIconColor: Colors.white),
      buttonTheme: ButtonThemeData(
        buttonColor: DesktopColors.buttonPrimary,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
