class Utility {
  static String getTitleByIndex(int index) {
    switch (index) {
      case 0:
        return 'Inicio';
      case 1:
        return 'Generar Cotización';
      case 2:
        return 'Historial';
      // case 3:
      //   return 'Favorites';
      // case 4:
      //   return 'Custom iconWidget';
      // case 5:
      //   return 'Profile';
      // case 6:
      //   return 'Settings';
      default:
        return 'Not found page';
    }
  }

  static double getWidthDynamic(double width) {
    double outWidth = 300;
    if (width < 650) {
      outWidth = width * 0.5;
    }
    return outWidth;
  }

  static String getLengthStay(String? fechaEntrada, int? 
  noches) {
    String date = "";
    DateTime time = DateTime.parse(fechaEntrada!);
    time.add(Duration(days: noches! + 1));
    date = "$fechaEntrada a ${time.toString().substring(0, 10)}";
    return date;
  }
}
