import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/numero_cotizacion_model.dart';
import 'package:generador_formato/models/periodo_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/widgets/controller_calendar_widget.dart';
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
        return 'Configuración';
      case 4:
        return 'Gestión de usuarios';
      case 5:
        return 'Tarifario';
      case 12:
        return 'Detalle comprobante';
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

  static String formatterNumber(double number) {
    return NumberFormat.simpleCurrency(locale: 'EN-us', decimalDigits: 2)
        .format(number);
  }

  static String getCompleteDate({DateTime? data, bool compact = false}) {
    String date = "";

    if (!compact) {
      Intl.defaultLocale = "es_ES";
      DateTime nowDate = data ?? DateTime.now();
      DateFormat formatter = DateFormat('dd - MMMM - yyyy');
      date = formatter.format(nowDate);
      date = date.replaceAll(r'-', "de");
    } else {
      DateTime nowDate = data ?? DateTime.now();
      DateFormat formatter = DateFormat('dd - MM - yy');
      date = formatter.format(nowDate);
      date = date.replaceAll(r'-', "/");
    }

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
        firstDayNextMonth.subtract(const Duration(days: 1));

    return lastDayCurrentMonth.day;
  }

  static List<NumeroCotizacion> getDailyQuotesReport(
      {List<CotizacionData>? respIndToday}) {
    List<NumeroCotizacion> cot = [];

    NumeroCotizacion cotizacionesGrupales =
        NumeroCotizacion(tipoCotizacion: "Cotizaciones grupales");

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
    return null;
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
    return null;
  }

  static String getOcupattionMessage(List<Habitacion> cotizaciones) {
    String occupation = "";
    int adultos = 0;
    int menores0a6 = 0;
    int menores7a12 = 0;

    if (adultos > 0) occupation += "$adultos adulto${adultos > 1 ? "s" : ""}";

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
        .difference(DateTime.parse(cotizaciones.last.fechaCheckIn!))
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
          const Color.fromARGB(255, 140, 207, 240)
        ];
      case "Cotizaciones grupales en Preventa":
        return [
          DesktopColors.cotGroupPreColor,
          const Color.fromARGB(255, 102, 232, 79)
        ];
      case "Cotizaciones individuales":
        return [
          DesktopColors.cotIndiv,
          const Color.fromARGB(255, 73, 185, 255)
        ];
      case "Cotizaciones individuales en Preventa":
        return [
          DesktopColors.cotGrupal,
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
        return DesktopColors.cotIndiv;
      case "Cotizaciones individuales en Preventa":
        return DesktopColors.cotGrupal;
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
    return null;
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

    subtotalString = subtotal.round().toString();

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

  static String calculatePromotion(
      TextEditingController tarifa, TextEditingController promocion, int desc) {
    double subtotal = 0;
    double tarifaNum = double.parse(tarifa.text.isEmpty ? '0' : tarifa.text);
    double promocionNUM =
        double.parse(promocion.text.isEmpty ? '0' : promocion.text);

    double descuento = (tarifaNum / 100) * (promocionNUM + desc);

    subtotal = tarifaNum - descuento;

    return formatterNumber(subtotal.round().toDouble());
  }

  static bool showTariffByWeek(
      List<PeriodoData>? periodos, DateTime initDayWeekGraphics) {
    bool show = false;

    for (var element in periodos!) {
      if ((initDayWeekGraphics.compareTo(element.fechaFinal!) <= -1 &&
              (initDayWeekGraphics
                      .add(const Duration(days: 6))
                      .compareTo(element.fechaFinal!) >=
                  1)) ||
          (initDayWeekGraphics.compareTo(element.fechaInicial!) == -1 &&
              (initDayWeekGraphics
                      .add(const Duration(days: 6))
                      .compareTo(element.fechaInicial!) ==
                  1)) ||
          (initDayWeekGraphics.compareTo(element.fechaInicial!) >= 0 &&
              (initDayWeekGraphics
                      .add(const Duration(days: 6))
                      .compareTo(element.fechaFinal!) <=
                  0)) ||
          initDayWeekGraphics
                  .add(const Duration(days: 6))
                  .compareTo(element.fechaInicial!) ==
              0 ||
          initDayWeekGraphics.compareTo(element.fechaFinal!) == 0) {
        show = true;
      }
    }

    return show;
  }

  static String getStringPeriod({
    required DateTime initDate,
    required DateTime lastDate,
    bool compact = true,
  }) {
    String periodo = '';
    Intl.defaultLocale = "es_ES";

    if (initDate.isSameDate(lastDate)) {
      periodo =
          "${lastDate.day} ${DateFormat('MMMM').format(lastDate).substring(0, 1).toUpperCase() + DateFormat('MMMM').format(lastDate).substring(1, compact ? 3 : null)}";
    } else if (initDate.month == lastDate.month &&
        initDate.year == lastDate.year) {
      periodo =
          "${initDate.day} - ${lastDate.day} ${DateFormat('MMMM').format(lastDate).substring(0, 1).toUpperCase() + DateFormat('MMMM').format(lastDate).substring(1, compact ? 3 : null)}";
    } else if (initDate.year == lastDate.year) {
      periodo =
          "${initDate.day} ${DateFormat('MMMM').format(initDate).substring(0, 1).toUpperCase() + DateFormat('MMMM').format(initDate).substring(1, compact ? 3 : null)} - ${lastDate.day} ${DateFormat('MMMM').format(lastDate).substring(0, 1).toUpperCase() + DateFormat('MMMM').format(lastDate).substring(1, compact ? 3 : null)}";
    } else {
      periodo = compact
          ? "${initDate.day}/${initDate.month}/${initDate.year.toString().substring(2)} - ${lastDate.day}/${lastDate.month}/${lastDate.year.toString().substring(2)}"
          : "${initDate.day} ${DateFormat('MMMM').format(initDate).substring(0, 1).toUpperCase() + DateFormat('MMMM').format(initDate).substring(1, compact ? 3 : null)} ${initDate.year} - ${lastDate.day} ${DateFormat('MMMM').format(lastDate).substring(0, 1).toUpperCase() + DateFormat('MMMM').format(lastDate).substring(1, compact ? 3 : null)} ${lastDate.year.toString().substring(2)}";
    }

    return periodo;
  }

  static PeriodoData getPeriodNow(
      DateTime weekNow, List<PeriodoData>? periodos) {
    PeriodoData dataNow = const PeriodoData(id: 0, code: "###");

    for (var element in periodos!) {
      if ((element.fechaInicial!.compareTo(weekNow) >= 0 &&
              (element.fechaInicial!
                      .compareTo(weekNow.add(const Duration(days: 6))) <=
                  0)) ||
          (element.fechaInicial!.compareTo(weekNow) <= 0 &&
              (element.fechaFinal!.compareTo(weekNow) >= 0 ||
                  element.fechaFinal!
                          .compareTo(weekNow.add(const Duration(days: 6))) >=
                      0))) {
        dataNow = element;
        break;
      }
    }
    return dataNow;
  }

  static String definePeriodNow(DateTime weekNow, List<PeriodoData>? periodos,
      {bool compact = false}) {
    String periodo = "01 Enero a 14 Marzo";

    PeriodoData periodNow = getPeriodNow(weekNow, periodos);
    periodo = getStringPeriod(
      initDate: periodNow.fechaInicial!,
      lastDate: periodNow.fechaFinal!,
      compact: compact,
    );

    return periodo;
  }

  static List<DateTime> generateSegmentWeek(DateTime weekNow) {
    List<DateTime> weekSegment = [];

    for (var day = 0; day < 7; day++) {
      DateTime dayNow = weekNow.add(Duration(days: day));
      weekSegment.add(DateTime(dayNow.year, dayNow.month, dayNow.day));
    }

    return weekSegment;
  }

  static bool revisedValidDays(int indexOf, List<DateTime> weekNowSegment,
      DateTime element, DateTime fechaInicial, DateTime fechaFinal) {
    bool isValid = false;

    if (element.subtract(const Duration(days: 1)).compareTo(fechaInicial) >=
            0 &&
        element.subtract(const Duration(days: 1)).compareTo(fechaFinal) <= 0) {
      isValid = true;
    }

    if (element.add(const Duration(days: 1)).compareTo(fechaInicial) >= 0 &&
        element.add(const Duration(days: 1)).compareTo(fechaFinal) <= 0) {
      isValid = true;
    }

    if (element.compareTo(fechaFinal) > 0) {
      isValid = false;
    }

    return isValid;
  }

  static bool defineApplyDays(PeriodoData nowPeriod, DateTime element) {
    switch (element.weekday) {
      case 1:
        return !nowPeriod.enLunes!;
      case 2:
        return !nowPeriod.enMartes!;
      case 3:
        return !nowPeriod.enMiercoles!;
      case 4:
        return !nowPeriod.enJueves!;
      case 5:
        return !nowPeriod.enViernes!;
      case 6:
        return !nowPeriod.enSabado!;
      case 7:
        return !nowPeriod.enDomingo!;
      default:
        return false;
    }
  }

  static double getExpandedDayWeek(
      double sectionDay, PeriodoData nowPeriod, DateTime element) {
    final int weekday = element.weekday;

    if (weekday < 1 || weekday > 7) {
      return 0;
    }
    final List<bool> days = [
      nowPeriod.enLunes!,
      nowPeriod.enMartes!,
      nowPeriod.enMiercoles!,
      nowPeriod.enJueves!,
      nowPeriod.enViernes!,
      nowPeriod.enSabado!,
      nowPeriod.enDomingo!,
    ];

    double flex = 0;
    for (int i = weekday - 1; i < days.length; i++) {
      if (getLimitDaysInWeek(
          element.add(Duration(days: i - weekday)), nowPeriod.fechaFinal!)) {
        if (days[i]) {
          flex += sectionDay;
        } else {
          break;
        }
      }
    }

    return flex;
  }

  static bool getLimitDaysInWeek(DateTime initDate, DateTime lastDate) {
    bool isValid = true;

    isValid = initDate.compareTo(lastDate) < 0;
    return isValid;
  }

  static String defineStatusPeriod(PeriodoData nowPeriod) {
    String status = "TERMINADA";
    DateTime nowDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (nowDate.compareTo(nowPeriod.fechaInicial!) >= 0 &&
        nowDate.compareTo(nowPeriod.fechaFinal!) <= 0) {
      status = "EN PROCESO";
    }

    if (nowDate.compareTo(nowPeriod.fechaInicial!) < 0 &&
        nowDate.compareTo(nowPeriod.fechaFinal!) < 0) {
      status = "VIGENTE";
    }

    if (nowDate.compareTo(nowPeriod.fechaInicial!) > 0 &&
        nowDate.compareTo(nowPeriod.fechaFinal!) > 0) {
      status = "TERMINADA";
    }

    if (nowDate.compareTo(nowPeriod.fechaFinal!) == 0) {
      status = "TERMINA HOY";
    }

    return status;
  }

  static double calculatePercentagePeriod(PeriodoData nowPeriod) {
    double porcentaje = 0;
    int totalDays = 0;
    int nowTotalDays = 0;

    if (!nowPeriod.fechaInicial!.isSameDate(nowPeriod.fechaFinal!)) {
      totalDays =
          nowPeriod.fechaFinal!.difference(nowPeriod.fechaInicial!).inDays + 1;
      nowTotalDays = DateTime.now()
          // .subtract(const Duration(days: 1))
          .difference(nowPeriod.fechaInicial!)
          .inDays;
    } else {
      totalDays = nowPeriod.fechaFinal!
          .add(const Duration(days: 1))
          .difference(nowPeriod.fechaInicial!)
          .inHours;
      nowTotalDays = DateTime.now().difference(nowPeriod.fechaInicial!).inHours;
    }
    porcentaje = (nowTotalDays / totalDays) * 100;

    if (porcentaje.isNegative) {
      porcentaje = 0;
    }

    if (porcentaje > 100) {
      porcentaje = 100;
    }

    return porcentaje;
  }

  static bool getRevisedActually(PeriodoData nowPeriod) {
    bool opacity = false;

    DateTime nowDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (nowDate.compareTo(nowPeriod.fechaInicial!) > 0 &&
        nowDate.compareTo(nowPeriod.fechaFinal!) > 0) {
      opacity = true;
    }

    return opacity;
  }

  static Widget getIconStatusPeriod(PeriodoData nowPeriod, Color color) {
    Widget icon = RotatedBox(
      quarterTurns: 3,
      child: Icon(
        CupertinoIcons.chevron_right_2,
        size: 15,
        color: useWhiteForeground(color) ? Colors.white : Colors.black,
      ),
    );

    DateTime nowDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (nowDate.compareTo(nowPeriod.fechaInicial!) < 0 &&
        nowDate.compareTo(nowPeriod.fechaFinal!) < 0) {
      icon = Icon(CupertinoIcons.time,
          color: useWhiteForeground(color) ? Colors.white : Colors.black,
          size: 15);
    }

    if (nowDate.compareTo(nowPeriod.fechaInicial!) > 0 &&
        nowDate.compareTo(nowPeriod.fechaFinal!) > 0) {
      icon = Icon(Icons.done_all_outlined,
          color: useWhiteForeground(color) ? Colors.white : Colors.black,
          size: 15);
    }

    return icon;
  }

  static DateTime getInitsWeekMonth(DateTime initWeekMonth, int i) {
    DateTime initWeek = initWeekMonth;

    if (i == 0) {
      initWeek =
          initWeekMonth.subtract(Duration(days: initWeekMonth.weekday - 1));
    } else {
      initWeek = initWeekMonth
          .add(Duration(days: (7 - initWeekMonth.weekday + 1) + ((i - 1) * 7)));
    }
    return initWeek;
  }

  static int getWeeksMonth(DateTime initWeekMonth) {
    int weeks = 6;
    int daysInMonth =
        DateTime(initWeekMonth.year, initWeekMonth.month + 1, 0).day;
    DateTime firstDayOfMonth =
        DateTime(initWeekMonth.year, initWeekMonth.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;
    int lastDayOfMonth =
        7 - DateTime(initWeekMonth.year, initWeekMonth.month + 1, 0).weekday;

    if (((daysInMonth + (weekdayOfFirstDay - 1)) + lastDayOfMonth) <= 35) {
      weeks = 5;
    }

    return weeks;
  }

  static bool showTariffNow(DateTime nowDay, List<PeriodoData>? periodos) {
    bool show = false;

    if (periodos!.any((element) =>
        (nowDay.compareTo(element.fechaInicial!) >= 0 &&
            (nowDay.compareTo(element.fechaFinal!) <= 0)) ||
        (nowDay.compareTo(element.fechaInicial!) == 0 ||
            nowDay.compareTo(element.fechaFinal!) == 0))) {
      PeriodoData nowPeriod = periodos.firstWhere((element) =>
          (nowDay.compareTo(element.fechaInicial!) >= 0 &&
              (nowDay.compareTo(element.fechaFinal!) <= 0)) ||
          (nowDay.compareTo(element.fechaInicial!) == 0 ||
              nowDay.compareTo(element.fechaFinal!) == 0));

      final List<bool> days = [
        nowPeriod.enLunes!,
        nowPeriod.enMartes!,
        nowPeriod.enMiercoles!,
        nowPeriod.enJueves!,
        nowPeriod.enViernes!,
        nowPeriod.enSabado!,
        nowPeriod.enDomingo!,
      ];

      for (int i = nowDay.weekday - 1; i < days.length; i++) {
        if (days[i]) {
          show = true;
        } else {
          break;
        }
      }
    }

    return show;
  }

  static RegistroTarifa? revisedTariffDay(
      DateTime daySelect, List<RegistroTarifa> list) {
    RegistroTarifa? first;

    if (list.any((element) => element.periodos!.any((element) =>
        ((daySelect.compareTo(element.fechaInicial!) == 0 &&
                daySelect.compareTo(element.fechaFinal!) == 0) &&
            element.fechaInicial!.isSameDate(element.fechaFinal!))))) {
      return list
          .where((element) => element.periodos!.any((element) =>
              ((daySelect.compareTo(element.fechaInicial!) == 0 &&
                      daySelect.compareTo(element.fechaFinal!) == 0) &&
                  element.fechaInicial!.isSameDate(element.fechaFinal!))))
          .firstOrNull;
    }

    first = list
        .where((element) => showTariffNow(daySelect, element.periodos))
        .firstOrNull;

    if (first == null) {
      return first;
    } else {
      return first.copyWith();
    }
  }

  static List<Periodo> getPeriodsRegister(List<PeriodoData>? periods) {
    List<Periodo> periodos = [];

    for (var element in periods!) {
      Periodo periodNow = Periodo(
          fechaFinal: element.fechaFinal, fechaInicial: element.fechaInicial);
      periodos.add(periodNow);
    }

    return periodos;
  }

  static String defineStatusTariff(List<PeriodoData>? periodos) {
    String status = "En proceso";
    int lenght = periodos!.length;
    int count = 0;

    for (var element in periodos) {
      if (getRevisedActually(element)) {
        count++;
      }
    }

    if (count >= lenght) {
      status = "Terminada";
    }

    return status;
  }

  static dynamic calculateTariffRoom({
    required Habitacion habitacion,
    required String initDay,
    required String lastDay,
    required List<RegistroTarifa> regitros,
    bool onlyAdults = false,
    bool onlyChildren = false,
    bool withFormat = true,
    bool withDiscount = true,
    bool onlyDiscount = false,
  }) {
    double totalTarifa = 0;

    for (var ink = 0;
        ink <
            DateTime.parse(lastDay).difference(DateTime.parse(initDay)).inDays;
        ink++) {
      RegistroTarifa? nowRegister = revisedTariffDay(
          DateTime.parse(initDay).add(Duration(days: ink)), regitros);

      double tariffAdult = calculateTariffAdult(
        nowRegister,
        habitacion,
        DateTime.parse(lastDay).difference(DateTime.parse(initDay)).inDays,
        withDiscount: withDiscount,
        onlyDiscount: onlyDiscount,
      );

      double tariffChildren = calculateTariffChildren(
        nowRegister,
        habitacion,
        DateTime.parse(lastDay).difference(DateTime.parse(initDay)).inDays,
        withDiscount: withDiscount,
        onlyDiscount: onlyDiscount,
      );

      if (onlyAdults) {
        totalTarifa = totalTarifa + tariffAdult;
        continue;
      }

      if (onlyChildren) {
        totalTarifa = totalTarifa + tariffChildren;
        continue;
      }

      totalTarifa = totalTarifa + (tariffAdult + tariffChildren);
    }
    if (withFormat) {
      return formatterNumber(totalTarifa);
    } else {
      return totalTarifa;
    }
  }

  static double calculateTariffAdult(
      RegistroTarifa? nowRegister, Habitacion habitacion, int totalDays,
      {bool withDiscount = true,
      bool onlyDiscount = false,
      double? descuentoProvisional}) {
    double tariffAdult = 0;

    if (nowRegister == null) {
      return 0;
    }

    TarifaData? nowTarifa = nowRegister.tarifas!
        .where((element) => element.categoria == habitacion.categoria)
        .firstOrNull;

    double descuento = 0;

    if (nowRegister.temporadas != null && nowRegister.temporadas!.isNotEmpty) {
      descuento =
          getSeasonNow(nowRegister, totalDays)?.porcentajePromocion ?? 0;
    } else {
      descuento = descuentoProvisional ?? 0;
    }

    switch (habitacion.adultos) {
      case 1 || 2:
        tariffAdult = nowTarifa?.tarifaAdultoSGLoDBL ?? 0;
        break;
      case 3:
        tariffAdult = nowTarifa?.tarifaAdultoTPL ?? 0;
        break;
      case 4:
        tariffAdult = nowTarifa?.tarifaAdultoCPLE ?? 0;
        break;
      default:
        tariffAdult = nowTarifa?.tarifaPaxAdicional ?? 0;
    }

    if (withDiscount) {
      tariffAdult =
          (tariffAdult - ((descuento / 100) * tariffAdult)).round().toDouble();
    }

    if (onlyDiscount) {
      tariffAdult = ((descuento / 100) * tariffAdult).round().toDouble();
    }

    return tariffAdult;
  }

  static double calculateTariffChildren(
    RegistroTarifa? nowRegister,
    Habitacion habitacion,
    int totalDays, {
    bool withDiscount = true,
    bool onlyDiscount = false,
    double? descuentoProvisional,
  }) {
    double tariffChildren = 0;

    if (nowRegister == null) {
      return 0;
    }

    TarifaData? nowTarifa = nowRegister.tarifas!
        .where((element) => element.categoria == habitacion.categoria)
        .firstOrNull;

    tariffChildren =
        (nowTarifa?.tarifaMenores7a12 ?? 0) * habitacion.menores7a12!;

    double descuento = 0;

    if (nowRegister.temporadas!.isNotEmpty) {
      descuento =
          getSeasonNow(nowRegister, totalDays)?.porcentajePromocion ?? 0;
    } else {
      descuento = descuentoProvisional ?? 0;
    }

    if (withDiscount) {
      tariffChildren = (tariffChildren - ((descuento / 100) * tariffChildren))
          .round()
          .toDouble();
    }

    if (onlyDiscount) {
      tariffChildren = ((descuento / 100) * tariffChildren).round().toDouble();
    }

    return tariffChildren;
  }

  static TemporadaData? getSeasonNow(
      RegistroTarifa? nowRegister, int totalDays) {
    if (nowRegister == null || nowRegister.temporadas == null) {
      return null;
    }

    TemporadaData? nowSeason;

    for (var element in nowRegister.temporadas!) {
      if (totalDays == element.estanciaMinima ||
          totalDays > element.estanciaMinima!) {
        nowSeason = element;
      }
    }

    return nowSeason;
  }

  static List<Temporada> getTemporadas(List<TemporadaData>? temporadasData) {
    List<Temporada> temporadas = [];

    int count = 0;

    for (var element in temporadasData!) {
      temporadas.add(
        Temporada(
          id: element.id,
          code: element.code,
          estanciaMinima: element.estanciaMinima,
          nombre: element.nombre,
          porcentajePromocion: element.porcentajePromocion,
          editable: !(count < 3),
        ),
      );
      count++;
    }

    return temporadas;
  }

  static Color darken(Color color, [double amount = .1]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static List<TarifaXDia> getUniqueTariffs(List<TarifaXDia> list) {
    List<TarifaXDia> tarifasFiltradas = [];
    tarifasFiltradas.clear();

    for (var element in list) {
      if (!tarifasFiltradas
          .any((elementInt) => elementInt.code == element.code)) {
        tarifasFiltradas.add(element.copyWith());
      } else {
        if (element.subCode == null) {
          if (tarifasFiltradas
              .any((elementInt) => elementInt.code == element.code)) {
            TarifaXDia? tarifaNow = tarifasFiltradas
                .where((elementInt) =>
                    elementInt.code == element.code &&
                    elementInt.subCode == null)
                .firstOrNull;
            if (tarifaNow != null) {
              tarifaNow.numDays++;
            } else {
              tarifasFiltradas.add(element.copyWith());
            }
          } else {
            tarifasFiltradas.add(element.copyWith());
          }
        } else {
          if (tarifasFiltradas
              .any((elementInt) => elementInt.subCode == element.subCode)) {
            TarifaXDia? tarifaNow = tarifasFiltradas
                .where((elementInt) =>
                    elementInt.code == element.code &&
                    elementInt.subCode == element.subCode)
                .firstOrNull;
            if (tarifaNow != null) {
              tarifaNow.numDays++;
            } else {
              tarifasFiltradas.add(element.copyWith());
            }
          } else {
            tarifasFiltradas.add(element.copyWith());
          }
        }
      }
    }
    return tarifasFiltradas;
  }

  static bool showWidgetResizable(
      {required double screenWidth,
      required bool extendSideBar,
      double limitWithExtend = 0,
      double limit = 0}) {
    bool showWidget = false;

    if (extendSideBar) {
      showWidget = screenWidth > limitWithExtend;
    } else {
      showWidget = screenWidth > limit;
    }

    return showWidget;
  }

  static bool verifAddRoomFree(
      List<Habitacion> habitaciones, int intervaloHabitacionGratuita,
      {bool isReduced = false}) {
    bool isValidForAdd = false;
    int rooms = 0;
    int freeRooms = 0;
    for (var element in habitaciones) {
      if (element.isFree) {
        freeRooms += element.count;
      } else {
        rooms += element.count;
      }
    }

    int freeRoomsValid = rooms ~/ intervaloHabitacionGratuita;

    if (freeRoomsValid > freeRooms) {
      isValidForAdd = true;
    }

    if (freeRoomsValid < freeRooms && isReduced) {
      isValidForAdd = true;
    }

    return isValidForAdd;
  }
}
