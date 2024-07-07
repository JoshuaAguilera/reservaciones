import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/cotizacion_diaria_model.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';
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

  static String getCompleteDate({DateTime? data}) {
    String date = "";
    Intl.defaultLocale = "es_ES";
    DateTime nowDate = data ?? DateTime.now();
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

  static String getNextMonth(String text) {
    return DateTime.parse(text)
        .add(const Duration(days: 30))
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

  static double calculateTarifaTotal(List<Cotizacion> cotizaciones,
      {bool esPreventa = false}) {
    double tarifaTotal = 0;
    for (var element in cotizaciones) {
      int days = DateTime.parse(element.fechaSalida!)
          .difference(DateTime.parse(element.fechaEntrada!))
          .inDays;
      tarifaTotal +=
          calculateTarifaDiaria(cotizacion: element, esPreventa: esPreventa) *
              days;
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

  static List<ReporteCotizacion> getReportQuotes(List<QuoteData> cotizaciones) {
    List<ReporteCotizacion> listCot = [];

    for (var i = 1; i < 8; i++) {
      ReporteCotizacion quoteDay = ReporteCotizacion(
        numCotizacionesGrupales: 0,
        numCotizacionesIndividual: 0,
        numCotizacionesGrupalesPreventa: 0,
        numCotizacionesIndividualPreventa: 0,
      );

      List<QuoteData> quotes = cotizaciones
          .where((element) => element.registerDate.weekday == i)
          .toList();

      for (var element in quotes) {
        if (element.isGroup) {
          if (element.isPresale) {
            quoteDay.numCotizacionesGrupalesPreventa++;
          } else {
            quoteDay.numCotizacionesGrupales++;
          }
        } else {
          if (element.isPresale) {
            quoteDay.numCotizacionesIndividualPreventa++;
          } else {
            quoteDay.numCotizacionesIndividual++;
          }
        }
      }

      quoteDay.dia = getNameDay(i);
      listCot.add(quoteDay);
    }

    return listCot;
  }

  static String getNameDay(int i) {
    switch (i) {
      case 1:
        return "Lunes";
      case 2:
        return "Martes";
      case 3:
        return "Miercoles";
      case 4:
        return "Jueves";
      case 5:
        return "Viernes";
      case 6:
        return "Sabado";
      case 7:
        return "Domingo";
      default:
        return "Unknow";
    }
  }

  static List<CotizacionDiaria> getDailyQuotesReport(
      List<QuoteData> respToday) {
    List<CotizacionDiaria> cot = [];

    CotizacionDiaria cotizacionesGrupales =
        CotizacionDiaria(tipoCotizacion: "Cotizaciones grupales");

    CotizacionDiaria cotizacionesGrupalesPreventa =
        CotizacionDiaria(tipoCotizacion: "Cotizaciones grupales en Preventa");

    CotizacionDiaria cotizacionesIndividuales =
        CotizacionDiaria(tipoCotizacion: "Cotizaciones individuales");

    CotizacionDiaria cotizacionesIndividualesPreventa = CotizacionDiaria(
        tipoCotizacion: "Cotizaciones individuales en Preventa");

    for (var element in respToday) {
      if (element.isGroup) {
        if (element.isPresale) {
          cotizacionesGrupalesPreventa.numCotizaciones++;
        } else {
          cotizacionesGrupales.numCotizaciones++;
        }
      } else {
        if (element.isPresale) {
          cotizacionesIndividualesPreventa.numCotizaciones++;
        } else {
          cotizacionesIndividuales.numCotizaciones++;
        }
      }
    }

    cot.addAll([
      cotizacionesGrupales,
      cotizacionesIndividuales,
      cotizacionesGrupalesPreventa,
      cotizacionesIndividualesPreventa,
    ]);

    return cot;
  }

  static bool foundQuotes(List<CotizacionDiaria> todayQuotes) {
    bool withQuotes = false;

    for (var element in todayQuotes) {
      if (element.numCotizaciones > 0) {
        withQuotes = true;
      }
    }

    return withQuotes;
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
    }
  }

  static IconData? getIconNavbar(String type) {
    switch (type) {
      case "alert":
        return CupertinoIcons.exclamationmark_octagon;
      case "danger":
        return CupertinoIcons.exclamationmark_triangle;
      case "success":
        return CupertinoIcons.checkmark_alt;
      case "info":
        return CupertinoIcons.exclamationmark_bubble;
      default:
    }
  }

  static String getOcupattionMessage(List<Cotizacion> cotizaciones) {
    String occupation = "";
    int adultos = 0;
    int menores0a6 = 0;
    int menores7a12 = 0;

    for (var element in cotizaciones) {
      adultos += element.adultos!;
      menores0a6 += element.menores0a6!;
      menores7a12 += element.menores7a12!;
    }

    if (adultos > 0) {
      occupation += "$adultos adulto${adultos > 1 ? "s" : ""}";
    }

    if (menores0a6 > 0) {
      occupation +=
          "${adultos > 0 ? "\, " : menores7a12 > 0 ? "" : " y "}$menores0a6 menore${menores0a6 > 1 ? "s" : ""} de 0 a 6";
    }

    if (menores7a12 > 0) {
      occupation +=
          "${(menores0a6 > 0 || adultos > 0) ? " y " : ""} $menores7a12 menore${menores7a12 > 1 ? "s" : ""} de 7 a 12";
    }

    return occupation;
  }

  static String getPeriodReservation(List<Cotizacion> cotizaciones) {
    String period = "";
    Intl.defaultLocale = "es_ES";

    DateTime initTime = DateTime.parse(cotizaciones.first.fechaEntrada!);
    DateTime lastTime = DateTime.parse(cotizaciones.first.fechaSalida!);
    DateFormat formatter = DateFormat('MMMM');

    if (lastTime.month == initTime.month) {
      period += "${initTime.day} al ${getCompleteDate(data: lastTime)}";
    } else {
      period +=
          "${initTime.day} de ${formatter.format(initTime)} al ${getCompleteDate(data: lastTime)}";
    }

    return period;
  }

  static int getDifferenceInDays({List<Cotizacion>? cotizaciones}) {
    int days = DateTime.parse(cotizaciones!.first.fechaSalida!)
        .difference(DateTime.parse(cotizaciones!.last.fechaEntrada!))
        .inDays;

    return days;
  }
}
