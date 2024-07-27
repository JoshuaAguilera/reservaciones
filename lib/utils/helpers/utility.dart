import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/cotizacion_grupal_model.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:intl/intl.dart';

import 'web_colors.dart';

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

  static List<ReporteCotizacion> getReportQuotes(
      {List<QuoteData>? cotizacionesInd,
      required String filter,
      List<QuoteGroupData>? cotizacionesGroup}) {
    List<ReporteCotizacion> listCot = [];
    DateTime now = DateTime.now();

    switch (filter) {
      case "Semanal":
        try {
          for (var i = 1; i < 8; i++) {
            ReporteCotizacion quoteDay = ReporteCotizacion(
              numCotizacionesGrupales: 0,
              numCotizacionesIndividual: 0,
              numCotizacionesGrupalesPreventa: 0,
              numCotizacionesIndividualPreventa: 0,
            );

            if (cotizacionesInd != null) {
              List<QuoteData> quotesInd = cotizacionesInd
                  .where((element) => element.registerDate.weekday == i)
                  .toList();

              for (var element in quotesInd) {
                if (element.isPresale) {
                  quoteDay.numCotizacionesIndividualPreventa++;
                } else {
                  quoteDay.numCotizacionesIndividual++;
                }
              }
            }

            if (cotizacionesGroup != null) {
              List<QuoteGroupData> quotesInd = cotizacionesGroup
                  .where((element) => element.registerDate.weekday == i)
                  .toList();

              for (var element in quotesInd) {
                if (element.isPresale) {
                  quoteDay.numCotizacionesGrupalesPreventa++;
                } else {
                  quoteDay.numCotizacionesGrupales++;
                }
                // }
              }
            }

            quoteDay.dia = dayNames[i - 1];
            listCot.add(quoteDay);
          }
        } catch (e) {
          print(e);
        }
        break;
      case "Mensual":
        for (var i = 1; i < getDaysInMonth(now.year, now.month) + 1; i++) {
          ReporteCotizacion quoteDay = ReporteCotizacion(
            numCotizacionesGrupales: 0,
            numCotizacionesIndividual: 0,
            numCotizacionesGrupalesPreventa: 0,
            numCotizacionesIndividualPreventa: 0,
          );

          if (cotizacionesInd != null) {
            List<QuoteData> quotes = cotizacionesInd
                .where((element) => element.registerDate.day == i)
                .toList();

            for (var element in quotes) {
              if (element.isPresale) {
                quoteDay.numCotizacionesIndividualPreventa++;
              } else {
                quoteDay.numCotizacionesIndividual++;
              }
              // }
            }
          }

          if (cotizacionesGroup != null) {
            List<QuoteGroupData> quotes = cotizacionesGroup
                .where((element) => element.registerDate.day == i)
                .toList();

            for (var element in quotes) {
              if (element.isPresale) {
                quoteDay.numCotizacionesGrupalesPreventa++;
              } else {
                quoteDay.numCotizacionesGrupales++;
              }
              // }
            }
          }

          quoteDay.dia = "$i";
          listCot.add(quoteDay);
        }
        break;
      case "Anual":
        for (var i = 1; i < 12 + 1; i++) {
          ReporteCotizacion quoteDay = ReporteCotizacion(
            numCotizacionesGrupales: 0,
            numCotizacionesIndividual: 0,
            numCotizacionesGrupalesPreventa: 0,
            numCotizacionesIndividualPreventa: 0,
          );

          if (cotizacionesInd != null) {
            List<QuoteData> quotes = cotizacionesInd
                .where((element) => element.registerDate.month == i)
                .toList();

            for (var element in quotes) {
              if (element.isPresale) {
                quoteDay.numCotizacionesIndividualPreventa++;
              } else {
                quoteDay.numCotizacionesIndividual++;
              }
              // }
            }
          }

          if (cotizacionesGroup != null) {
            List<QuoteGroupData> quotes = cotizacionesGroup
                .where((element) => element.registerDate.month == i)
                .toList();

            for (var element in quotes) {
              if (element.isPresale) {
                quoteDay.numCotizacionesGrupalesPreventa++;
              } else {
                quoteDay.numCotizacionesGrupales++;
              }
            }
          }

          quoteDay.dia = monthNames[i - 1];
          listCot.add(quoteDay);
        }

        break;
      default:
    }

    return listCot;
  }

  static int getDaysInMonth(int year, int month) {
    int nextMonth = month == 12 ? 1 : month + 1;
    int nextMonthYear = month == 12 ? year + 1 : year;

    DateTime firstDayNextMonth = DateTime(nextMonthYear, nextMonth, 1);
    DateTime lastDayCurrentMonth =
        firstDayNextMonth.subtract(Duration(days: 1));

    return lastDayCurrentMonth.day;
  }

  static List<NumeroCotizacion> getDailyQuotesReport(
      {List<QuoteData>? respIndToday, List<QuoteGroupData>? respGroupToday}) {
    List<NumeroCotizacion> cot = [];

    NumeroCotizacion cotizacionesGrupales =
        NumeroCotizacion(tipoCotizacion: "Cotizaciones grupales");

    // NumeroCotizacion cotizacionesGrupalesPreventa =
    //     NumeroCotizacion(tipoCotizacion: "Cotizaciones grupales en Preventa");

    NumeroCotizacion cotizacionesIndividuales =
        NumeroCotizacion(tipoCotizacion: "Cotizaciones individuales");

    NumeroCotizacion cotizacionesIndividualesPreventa = NumeroCotizacion(
        tipoCotizacion: "Cotizaciones individuales en Preventa");

    for (var element in respIndToday!) {
      if (element.isPresale) {
        cotizacionesIndividualesPreventa.numCotizaciones++;
      } else {
        cotizacionesIndividuales.numCotizaciones++;
      }
    }

    for (var element in respGroupToday!) {
      if (element.isPresale) {
        // cotizacionesGrupalesPreventa.numCotizaciones++;
      } else {
        cotizacionesGrupales.numCotizaciones++;
      }
    }

    cot.addAll([
      cotizacionesGrupales,
      cotizacionesIndividuales,
      // cotizacionesGrupalesPreventa,
      cotizacionesIndividualesPreventa,
    ]);

    return cot;
  }

  static bool foundQuotes(List<NumeroCotizacion> todayQuotes) {
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

  static IconData? getIconCardDashboard(String? tipoCotizacion) {
    switch (tipoCotizacion) {
      case "Cotizaciones grupales":
        return CupertinoIcons.person_2;
      case "Cotizaciones grupales en Preventa":
        return CupertinoIcons.person_2_fill;
      case "Cotizaciones individuales":
        return CupertinoIcons.person;
      case "Cotizaciones individuales en Preventa":
        return CupertinoIcons.person_fill;
      default:
        return Icons.error_outline;
    }
  }

  static List<Color> getGradientQuote(String? tipoCotizacion) {
    switch (tipoCotizacion) {
      case "Cotizaciones grupales":
        return [
          DesktopColors.cotGroupColor,
          Color.fromARGB(255, 140, 207, 240)
        ];
      case "Cotizaciones grupales en Preventa":
        return [
          DesktopColors.cotGroupPreColor,
          const Color.fromARGB(255, 102, 232, 79)
        ];
      case "Cotizaciones individuales":
        return [
          DesktopColors.cotIndColor,
          const Color.fromARGB(255, 73, 185, 255)
        ];
      case "Cotizaciones individuales en Preventa":
        return [
          DesktopColors.cotIndPreColor,
          const Color.fromARGB(255, 255, 205, 124)
        ];
      default:
        return [];
    }
  }

  static DateTime calculatePeriodReport(String filter) {
    DateTime initPeriod = DateTime.now();

    switch (filter) {
      case "Semanal":
        int numDay = initPeriod.weekday;
        initPeriod = initPeriod.subtract(Duration(days: numDay));
        break;
      case "Mensual":
        initPeriod = initPeriod.subtract(Duration(days: initPeriod.day));
        break;
      case "Anual":
        initPeriod = DateTime(initPeriod.year, 1, 1);
        break;
      default:
    }

    return initPeriod;
  }

  static double getWidthDynamicCarrousel(double screenWidth) {
    double width = screenWidth;

    switch (screenWidth) {
      case >= 400 && <= 799:
        width *= 0.7;
        break;
      case >= 800 && <= 1099:
        width *= 0.5;
        break;
      case >= 1100:
        width *= 0.3;
        break;
      default:
    }

    return width;
  }

  static String getDatesStay(List<CotizacionGrupal> cotizaciones) {
    String dates = '';

    for (var element in cotizaciones) {
      dates += "${element.fechaEntrada!} - ${element.fechaSalida!}, ";
    }

    return dates;
  }

  static Color getColorRegisterQuote(String type) {
    switch (type) {
      case "Cotizaciones grupales":
        return DesktopColors.cotGroupColor;
      case "Cotizaciones grupales en Preventa":
        return DesktopColors.cotGroupPreColor;
      case "Cotizaciones individuales":
        return DesktopColors.cotIndColor;
      case "Cotizaciones individuales en Preventa":
        return DesktopColors.cotIndPreColor;
      default:
        return Colors.white;
    }
  }
}
