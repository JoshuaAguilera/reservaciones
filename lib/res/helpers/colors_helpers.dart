import 'package:flutter/material.dart';

import 'desktop_colors.dart';

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

  static List<Color> getGradientQuote(String? tipoCotizacion) {
    switch (tipoCotizacion) {
      case "Cotizaciones grupales":
        return [
          DesktopColors.cotGrupal,
          const Color.fromARGB(255, 255, 205, 124)
        ];
      case "Reservaciones grupales":
        return [
          DesktopColors.resGrupal,
          const Color.fromARGB(255, 226, 109, 31)
        ];
      case "Cotizaciones individuales":
        return [
          DesktopColors.cotIndiv,
          const Color.fromARGB(255, 73, 185, 255)
        ];
      case "Reservaciones individuales":
        return [
          DesktopColors.resIndiv,
          const Color.fromARGB(255, 140, 207, 240)
        ];
      case "Cotizaciones no concretadas":
        return [
          DesktopColors.cotNoConcr,
          DesktopColors.grisPalido,
        ];
      default:
        return [];
    }
  }

  static Color getColorRegisterQuote(String type) {
    switch (type) {
      case "Cotizaciones grupales":
        return DesktopColors.cotGrupal;
      case "Reservaciones grupales":
        return DesktopColors.resGrupal;
      case "Cotizaciones individuales":
        return DesktopColors.cotIndiv;
      case "Reservaciones individuales":
        return DesktopColors.resIndiv;
      case "Cotizaciones no concretadas":
        return DesktopColors.cotNoConcr;
      default:
        return Colors.white;
    }
  }
}
