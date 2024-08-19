import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/widgets/text_styles.dart';
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
      case 3:
        return 'Configuracion';
      case 99:
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
      {required Habitacion cotizacion, bool esPreventa = false}) {
    double tarifaTotal = 0;

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

  static double calculateTarifaTotal(List<Habitacion> cotizaciones,
      {bool esPreventa = false}) {
    double tarifaTotal = 0;
    for (var element in cotizaciones) {
      int days = DateTime.parse(element.fechaCheckOut!)
          .difference(DateTime.parse(element.fechaCheckIn!))
          .inDays;
      tarifaTotal +=
          calculateTarifaDiaria(cotizacion: element, esPreventa: esPreventa) *
              days;
    }

    return tarifaTotal;
  }

  static double? limitHeightList(int length,
      [int maxItems = 3, double maxHeight = 290]) {
    double? height;
    if (length > maxItems) {
      height = maxHeight;
    }
    return height;
  }

  static List<ReporteCotizacion> getCotizacionQuotes({
    List<CotizacionData>? cotizaciones,
    required String filter,
  }) {
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

            if (cotizaciones != null) {
              List<CotizacionData> quotesInd = cotizaciones
                  .where((element) => element.fecha.weekday == i)
                  .toList();

              for (var element in quotesInd) {
                if (element.esGrupo!) {
                  quoteDay.numCotizacionesGrupales++;
                } else {
                  quoteDay.numCotizacionesIndividual++;
                }
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

          if (cotizaciones != null) {
            List<CotizacionData> quotes = cotizaciones
                .where((element) => element.fecha.day == i)
                .toList();

            for (var element in quotes) {
              if (element.esGrupo!) {
                quoteDay.numCotizacionesGrupales++;
              } else {
                quoteDay.numCotizacionesIndividual++;
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

          if (cotizaciones != null) {
            List<CotizacionData> quotes = cotizaciones
                .where((element) => element.fecha.month == i)
                .toList();

            for (var element in quotes) {
              if (element.esGrupo!) {
                quoteDay.numCotizacionesGrupales++;
              } else {
                quoteDay.numCotizacionesIndividual++;
              }
              // }
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
      {List<CotizacionData>? respIndToday}) {
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
      if (element.esGrupo!) {
        cotizacionesGrupales.numCotizaciones++;
      } else {
        cotizacionesIndividuales.numCotizaciones++;
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

  static String getOcupattionMessage(List<Habitacion> cotizaciones) {
    String occupation = "";
    int adultos = 0;
    int menores0a6 = 0;
    int menores7a12 = 0;

    // for (var element in cotizaciones) {
    //   adultos += element.adultos!;
    //   menores0a6 += element.menores0a6!;
    //   menores7a12 += element.menores7a12!;
    // }

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

  static String getPeriodReservation(List<Habitacion> cotizaciones) {
    String period = "";
    Intl.defaultLocale = "es_ES";

    DateTime initTime = DateTime.parse(cotizaciones.first.fechaCheckIn!);
    DateTime lastTime = DateTime.parse(cotizaciones.first.fechaCheckOut!);
    DateFormat formatter = DateFormat('MMMM');

    if (lastTime.month == initTime.month) {
      period += "${initTime.day} al ${getCompleteDate(data: lastTime)}";
    } else {
      period +=
          "${initTime.day} de ${formatter.format(initTime)} al ${getCompleteDate(data: lastTime)}";
    }

    return period;
  }

  static int getDifferenceInDays({List<Habitacion>? cotizaciones}) {
    int days = DateTime.parse(cotizaciones!.first.fechaCheckOut!)
        .difference(DateTime.parse(cotizaciones!.last.fechaCheckIn!))
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

  static String getDatesStay(List<Habitacion> habitaciones) {
    String dates = '';

    for (var element in habitaciones) {
      dates += "${element.fechaCheckIn!} - ${element.fechaCheckOut!}, ";
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

  static Color? getColorTypeUser(String rol) {
    switch (rol) {
      case "SUPERADMIN":
        return const Color.fromARGB(255, 255, 192, 1);
      case "ADMIN":
        return const Color.fromARGB(255, 202, 202, 202);
      case "VENTAS":
        return const Color.fromARGB(255, 10, 166, 180);
      default:
    }
  }

  static bool valueShowLimitDays(
      int numDays, int dayCheckIn, int dayCheckOut, int afterDay, int lastDay) {
    bool show = false;

    if ((dayCheckOut) >= afterDay || (dayCheckOut + 9) >= afterDay) {
      show = true;
    }

    return show;
  }

  static String defineMonthPeriod(String initDay, String lastDay) {
    String period = "";
    DateTime dataInit = DateTime.parse(initDay);
    DateTime dataLast = DateTime.parse(lastDay);

    if (dataInit.month == dataLast.month) {
      period = monthNames[dataInit.month - 1];
    } else {
      period =
          "${monthNames[dataInit.month - 1]} - ${monthNames[dataLast.month - 1]}";
    }

    return period;
  }

  static List<int> calcularMultiplos(int numero, int limite) {
    List<int> multiplos = [0];
    for (int i = 1; i <= limite; i++) {
      multiplos.add(numero * i);
    }
    return multiplos;
  }

  static int getLimitDays(
      int numDays, int dayWeekInit, int dayWeekLater, int numDayInit) {
    int day = 0;
    int daysExtras = 7 - dayWeekInit;
    daysExtras += 7 - dayWeekLater;
    int totalDays = numDayInit + numDays + daysExtras;
    double ceil = (totalDays / 7);
    day = ceil.ceil() + 2;
    // List<int> listWeeks = calcularMultiplos(7, (totalDays/7).ceil());

    return day;
  }

  static List<int> getLimitWeeks(
      int numDays, int dayWeekInit, int dayWeekLater, int numDayInit) {
    List<int> weeks = [];
    int daysExtras = 7 - dayWeekInit;
    daysExtras += 7 - dayWeekLater;
    int totalDays = numDayInit + numDays + daysExtras;
    double ceil = (totalDays / 7);
    weeks = calcularMultiplos(7, (ceil).ceil() + 2);

    return weeks;
  }

  static String getNameDay(int day) {
    switch (day) {
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

  static bool revisedLimitDateTime(DateTime checkIn, DateTime checkOut) {
    bool isValide = true;
    DateTime checkOutLimit = DateTime(checkIn.year, checkIn.month + 1, 1);

    if ((checkOut.month != checkIn.month) &&
        (checkOut.month != checkOutLimit.month)) {
      isValide = false;
    }

    if ((checkOut.month == checkOutLimit.month) &&
        (checkOut.day >= checkIn.day)) {
      isValide = false;
    }

    return isValide;
  }

  static String calculateRate(TextEditingController tarifaAdulto,
      TextEditingController tarifaPaxAdicional, int numPaxAdic) {
    String subtotalString = '0';
    double subtotal = 0;
    double tarifaAdultoNum =
        double.parse(tarifaAdulto.text.isEmpty ? '0' : tarifaAdulto.text);
    double tarifaPaxAdicNum = double.parse(
        tarifaPaxAdicional.text.isEmpty ? '0' : tarifaPaxAdicional.text);

    subtotal = tarifaAdultoNum + (tarifaPaxAdicNum * numPaxAdic);

    subtotalString = subtotal.toStringAsFixed(2);

    return subtotalString;
  }

  static List<Widget> generateTextWidget(
      List<String> list, Color? primaryColor) {
    List<Widget> children = [];

    for (var element in list) {
      children.add(TextStyles.standardText(text: element, color: primaryColor));
    }

    return children;
  }
}
