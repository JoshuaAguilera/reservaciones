import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:intl/intl.dart';

class Utility {
  static String getTitleByIndex(int index) {
    switch (index) {
      case 0:
        return 'Inicio';
      case 1:
        return 'Generar Cotización';
      case 2:
        return 'Historial';
      case 4:
        return 'Perfil';
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
    double outWidth = 350;
    if (width < 650) {
      outWidth = width * 0.5;
    }
    return outWidth;
  }

  static String getLengthStay(String? fechaEntrada, int? noches) {
    String date = "";
    DateTime time = DateTime.parse(fechaEntrada!);
    date =
        "$fechaEntrada a ${time.add(Duration(days: noches! + 1)).toString().substring(0, 10)}";
    return date;
  }

  static String formatterNumber(double number) {
    return NumberFormat.simpleCurrency(locale: 'EN-us', decimalDigits: 2)
        .format(number);
  }

  static String calculateTotal(int? numNoches, double? tarifaNoche) {
    double total = 0;
    total = (numNoches ?? 0) * (tarifaNoche ?? 0);
    return formatterNumber(total);
  }

  static String getPax(int pax) {
    String paxName = "";

    switch (pax) {
      case 1 || 2:
        paxName = "1 o 2";
        break;
      case 3:
        paxName = "3";
        break;
      case 4:
        paxName = "4";
        break;
      default:
    }
    return paxName;
  }

  static String getCompleteDate() {
    String date = "";
    Intl.defaultLocale = "es_ES";
    DateTime nowDate = DateTime.now();
    DateFormat formatter = DateFormat('dd - MMMM - yyyy');
    date = formatter.format(nowDate);
    date = date.replaceAll(r'-', "de");
    return date;
  }

  static double calculateTarifaDiaria(
      {required Cotizacion cotizacion, bool esPreventa = false}) {
    double tarifaTotal = 0;
    double tarifaAdulto = esPreventa
        ? cotizacion.tarifaPreventaAdulto ?? 0
        : cotizacion.tarifaRealAdulto ?? 0;
    double tarifaMenores = esPreventa
        ? cotizacion.tarifaPreventaMenor ?? 0
        : cotizacion.tarifaRealMenor ?? 0;

    tarifaTotal = (cotizacion.adultos! * tarifaAdulto) +
        (cotizacion.menores7a12! * tarifaMenores);

    return tarifaTotal;
  }

  static String getNextDay(String text) {
    return DateTime.parse(text)
        .add(const Duration(days: 1))
        .toIso8601String()
        .substring(0, 10);
  }

  static bool isResizable(
      {required bool extended,
      required BuildContext context,
      double minWidth = 700,
      double minWidthWithBar = 725}) {
    bool isVisible = true;
    final isSmallScreen = MediaQuery.of(context).size.width < minWidth;
    final isSmallScreenWithSideBar =
        MediaQuery.of(context).size.width < minWidthWithBar;
    isVisible = (extended) ? isSmallScreenWithSideBar : isSmallScreen;
    return isVisible;
  }

  static double calculateTarifaTotal(List<Cotizacion> cotizaciones) {
    double tarifaTotal = 0;
    for (var element in cotizaciones) {
      int days = DateTime.parse(element.fechaSalida!)
          .difference(DateTime.parse(element.fechaEntrada!))
          .inDays;
      tarifaTotal += calculateTarifaDiaria(cotizacion: element) * days;
    }

    return tarifaTotal;
  }

  static double? limitHeightList(int length) {
    double? height;
    if (length > 3) {
      height = 290;
    }
    return height;
  }
}
