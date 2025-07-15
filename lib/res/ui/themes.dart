import 'package:flutter/material.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';

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
      // canvasColor: DesktopColors.backgroudColor,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(DesktopColors.cerulean),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(closeIconColor: Colors.white),
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
        // bodySmall: TextStyles.styleStandar(color: Colors.black87, size: 10),
        // displaySmall: TextStyles.styleStandar(color: Colors.black87, size: 10),
        // labelSmall: TextStyles.styleStandar(color: Colors.black87, size: 10),
        // headlineSmall: TextStyles.styleStandar(color: Colors.black87, size: 10),
        // titleSmall: TextStyles.styleStandar(color: Colors.black87, size: 10),
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
          foregroundColor: WidgetStatePropertyAll(
            DesktopColors.buttonPrimary,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      snackBarTheme: const SnackBarThemeData(closeIconColor: Colors.white),
      buttonTheme: ButtonThemeData(
        buttonColor: DesktopColors.buttonPrimary,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
