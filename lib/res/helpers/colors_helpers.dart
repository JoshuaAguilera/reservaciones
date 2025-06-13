import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:generador_formato/res/helpers/desktop_colors.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String? colorToHex(Color? color) {
    if (color == null) {
      return null;
    }

    return '#${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }
}

class ColorsHelpers {
  static Color darken(Color color, [double amount = .1]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static Color? getColorNavbar(String type) {
    switch (type) {
      case "alert":
        return Colors.amber[700];
      case "danger":
        return Colors.red[800];
      case "success":
        return Colors.green[700];
      case "info":
        return Colors.blue[400];
      default:
        return null;
    }
  }

  static Color colorFromJson(String? color) {
    return HexColor.fromHex(
      color ?? HexColor.colorToHex(DesktopColors.cardColor)!,
    );
  }

  static String? colorToJson(Color? color) {
    return HexColor.colorToHex(color);
  }

  static Color? getColorTypeConcept(
    String concept, {
    int alpha = 255,
  }) {
    switch (concept) {
      case "Activa" || "registrado":
        return DesktopColors.buttonPrimary;
      case "Administrador":
        return Color.fromARGB(180, 255, 192, 1);
      case "Recepcion":
        return Color.fromARGB(180, 202, 202, 202);
      case "Cajero":
        return Color.fromARGB(180, 230, 92, 0);
      case "Desactivado":
        return DesktopColors.notDanger;
      case "Activo":
        return DesktopColors.notSuccess;
      default:
        return DesktopColors.grisPalido;
    }
  }
}
