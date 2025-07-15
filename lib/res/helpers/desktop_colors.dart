import 'package:flutter/material.dart';

import 'colors_helpers.dart';

class DesktopColors {
  //Colors Widget
  static Color cardColor = Color.fromARGB(255, 47, 42, 51);

  //Colors App
  static Color cerulean = Color.fromARGB(255, 0, 125, 167);
  static Color ceruleanOscure = Color.fromARGB(255, 0, 97, 129);
  static Color prussianBlue = Color.fromARGB(255, 0, 50, 73);
  static Color prussianWhiteBlue = Color.fromARGB(255, 0, 63, 92);
  static Color azulCielo = Color.fromARGB(255, 128, 206, 215);
  static Color azulClaro = Color.fromARGB(255, 154, 209, 212);
  static Color azulUltClaro = Color.fromARGB(255, 176, 239, 242);
  static Color turqueza = Color.fromARGB(255, 0, 192, 144);
  static Color turquezaOscure = Color.fromARGB(255, 3, 130, 98);
  static Color mentaOscure = Color.fromARGB(255, 82, 170, 138);
  static Color grisSemiPalido = Color.fromARGB(255, 85, 85, 85);
  static Color grisPalido = Color.fromARGB(255, 162, 162, 162);
  static Color greyClean = Color.fromARGB(255, 196, 196, 196);

  //Colors buttons
  static Color buttonPrimary = const Color.fromARGB(255, 84, 125, 201);

  //Colors sidebar
  static Color primaryColor = Color(0xFF685BFF);
  static Color canvasColor = Color(0xFF2E2E48);
  static Color scaffoldBackgroundColor = Color(0xFF464667);
  static Color accentCanvasColor = Color(0xFF3E3E61);
  static Color white = Colors.white;
  static Color actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
  static Divider divider = Divider(color: white.withOpacity(0.3), height: 2);

  //Colors Graphics
  static Color cotGrupal = Color.fromARGB(255, 233, 170, 69);
  static Color cotIndiv = Color.fromARGB(255, 26, 112, 166);
  static Color resGrupal = Color.fromARGB(255, 220, 108, 64);
  static Color resIndiv = Color.fromARGB(255, 76, 162, 205);
  static Color cotNoConcr = Color.fromARGB(255, 126, 126, 126);
  static Color notFound = const Color.fromARGB(255, 204, 202, 202);

  //Color notification
  static Color notNormal = Color.fromARGB(255, 74, 131, 204);
  static Color notDanger = Color.fromARGB(255, 204, 104, 74);
  static Color notSuccess = Color.fromARGB(255, 143, 204, 74);

  //Colors Settings Default
  static Color colorLogo = const Color.fromARGB(255, 6, 174, 181);
  static Color colorTablesInd = const Color.fromARGB(255, 0, 153, 153);
  static Color colorTablesGroup = const Color.fromARGB(255, 51, 204, 204);

  //Colors Plans
  static Color vistaReserva = Color.fromARGB(255, 72, 151, 89);
  static Color vistaParcialMar = Color.fromARGB(255, 35, 150, 179);

  //more...
  static Color cashSeason = const Color.fromRGBO(139, 195, 74, 1);
  static Color errorColor = const Color.fromARGB(255, 197, 19, 7);

  //Tarifiko Version 2.0.0
  static Color primary1 = HexColor.fromHex("#2c3c46");
  static Color primary2 = HexColor.fromHex("#2e8799");
  static Color primary3 = HexColor.fromHex("#30addb");
  static Color primary4 = HexColor.fromHex("#f05556");
  static Color primary5 = HexColor.fromHex("#f2981b");
  static Color primary6 = HexColor.fromHex("#3d5462");

  static List<Color> getQuotesColors() {
    return [cotGrupal, cotIndiv, resGrupal, resIndiv];
  }

  static List<Color> getPrimaryColors() {
    return [primary2, primary3, primary4, primary5, primary6];
  }
}
