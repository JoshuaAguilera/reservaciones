import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        bodyMedium: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.bodyMedium,
        ),
        displayMedium: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.displayMedium,
        ),
        labelMedium: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.labelMedium,
        ),
        headlineMedium: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.headlineMedium,
        ),
        titleMedium: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.titleMedium,
        ),
        titleLarge: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.titleLarge,
        ),
        bodyLarge: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.bodyLarge,
        ),
        titleSmall: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.titleSmall,
        ),
        bodySmall: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.bodySmall,
        ),
        displayLarge: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.displayLarge,
        ),
        displaySmall: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.displaySmall,
        ),
        headlineLarge: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.headlineLarge,
        ),
        headlineSmall: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.headlineSmall,
        ),
        labelLarge: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.labelLarge,
        ),
        labelSmall: TextStyles.styleStandar(
          color: Colors.white,
          size: AppTextSizes.labelSmall,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.2, color: Colors.transparent),
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
      dialogTheme: const DialogTheme(
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        
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
      dialogBackgroundColor: Colors.white,
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color.fromARGB(255, 238, 238, 238),
      cardTheme: const CardThemeData(
        color: Color.fromARGB(255, 238, 238, 238),
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.bodyMedium,
        ),
        displayMedium: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.displayMedium,
        ),
        labelMedium: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.labelMedium,
        ),
        headlineMedium: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.headlineMedium,
        ),
        titleMedium: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.titleMedium,
        ),
        titleLarge: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.titleLarge,
        ),
        bodyLarge: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.bodyLarge,
        ),
        titleSmall: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.titleSmall,
        ),
        bodySmall: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.bodySmall,
        ),
        displayLarge: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.displayLarge,
        ),
        displaySmall: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.displaySmall,
        ),
        headlineLarge: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.headlineLarge,
        ),
        headlineSmall: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.headlineSmall,
        ),
        labelLarge: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.labelLarge,
        ),
        labelSmall: TextStyles.styleStandar(
          color: Colors.black87,
          size: AppTextSizes.labelSmall,
        ),
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
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(
            DesktopColors.canvasColor,
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: DesktopColors.buttonPrimary,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}

class AppTextSizes {
  // Títulos principales (pantallas, diálogos grandes)
  static double get displayLarge =>
      _clamp(32.sp, min: 28, max: 54); // para portadas, headers
  static double get displayMedium => _clamp(26.sp, min: 24, max: 40);
  static double get displaySmall => _clamp(22.sp, min: 20, max: 32);

  // Titulares y subtítulos
  static double get headlineLarge => _clamp(20.sp, min: 18, max: 28);
  static double get headlineMedium => _clamp(18.sp, min: 16, max: 24);
  static double get headlineSmall => _clamp(16.sp, min: 14, max: 20);

  // Texto para secciones y botones grandes
  static double get titleLarge => _clamp(17.sp, min: 16, max: 22);
  static double get titleMedium => _clamp(15.sp, min: 14, max: 18);
  static double get titleSmall => _clamp(13.sp, min: 13, max: 16);

  // Texto base
  static double get bodyLarge => _clamp(16.sp, min: 15, max: 20);
  static double get bodyMedium => _clamp(14.sp, min: 13, max: 18);
  static double get bodySmall => _clamp(13.sp, min: 12, max: 16);

  // Etiquetas, botones pequeños, info secundaria
  static double get labelLarge => _clamp(13.sp, min: 12, max: 15);
  static double get labelMedium => _clamp(12.sp, min: 11, max: 14);
  static double get labelSmall => _clamp(11.sp, min: 10, max: 13);

  /// Utilidad interna para limitar el tamaño entre un mínimo y un máximo
  static double _clamp(double value,
          {required double min, required double max}) =>
      math.max(min, math.min(value, max));
}
