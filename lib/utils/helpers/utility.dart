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

    NumeroCotizacion reservacionesIndividuales =
        NumeroCotizacion(tipoCotizacion: "Reservaciones individuales");

    NumeroCotizacion reservacionesGrupales =
        NumeroCotizacion(tipoCotizacion: "Reservaciones grupales");

    for (var element in respIndToday ?? List<CotizacionData>.empty()) {
      if (element.esGrupo ?? false) {
        if (element.esConcretado ?? false) {
          reservacionesGrupales.numCotizaciones++;
        } else {
          cotizacionesGrupales.numCotizaciones++;
        }
      } else {
        if (element.esConcretado ?? false) {
          reservacionesIndividuales.numCotizaciones++;
        } else {
          cotizacionesIndividuales.numCotizaciones++;
        }
      }
    }

    cot.addAll([
      cotizacionesGrupales,
      cotizacionesIndividuales,
      reservacionesGrupales,
      reservacionesIndividuales,
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

  static String getOcupattionMessage(Habitacion room) {
    String occupation = "";
    int adultos = room.adultos ?? 0;
    int menores = (room.menores0a6 ?? 0) + (room.menores7a12 ?? 0);

    if (adultos > 0) occupation += "$adultos ADULTO${adultos > 1 ? "S" : ""}";

    if (menores > 0) {
      occupation +=
          "${adultos > 0 ? " Y " : ""}$menores MENOR${menores > 1 ? "ES" : ""}";
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

  static int getDifferenceInDays({List<Habitacion>? habitaciones}) {
    int days = DateTime.parse(habitaciones!.first.fechaCheckOut!)
        .difference(DateTime.parse(habitaciones.last.fechaCheckIn!))
        .inDays;

    return days;
  }

  static IconData? getIconCardDashboard(String? tipoCotizacion) {
    switch (tipoCotizacion) {
      case "Cotizaciones grupales":
        return CupertinoIcons.person_2_fill;
      case "Reservaciones grupales":
        return CupertinoIcons.person_2_fill;
      case "Cotizaciones individuales":
        return CupertinoIcons.person_fill;
      case "Reservaciones individuales":
        return CupertinoIcons.person_fill;
      default:
        return Icons.error_outline;
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
    DateTime firstDate = DateTime.parse(habitaciones.first.fechaCheckIn!);
    DateTime lastDate = DateTime.parse(habitaciones.last.fechaCheckOut!);

    if (firstDate.month == lastDate.month) {
      dates =
          "${firstDate.day} al ${lastDate.day} ${monthNames[firstDate.month - 1]} ${firstDate.year}";
    } else if (firstDate.year == lastDate.year) {
      dates =
          "${firstDate.day} ${monthNames[firstDate.month - 1]} al ${lastDate.day} ${monthNames[lastDate.month - 1]} ${firstDate.year}";
    } else {
      dates =
          "${firstDate.day} ${monthNames[firstDate.month - 1]} ${firstDate.year} al ${lastDate.day} ${monthNames[lastDate.month - 1]} ${firstDate.year}";
    }

    return dates;
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

      double tariffAdult = calculateTotalTariffRoom(
        nowRegister,
        habitacion,
        DateTime.parse(lastDay).difference(DateTime.parse(initDay)).inDays,
        withDiscount: withDiscount,
        onlyDiscount: onlyDiscount,
      );

      double tariffChildren = calculateTotalTariffRoom(
        nowRegister,
        habitacion,
        DateTime.parse(lastDay).difference(DateTime.parse(initDay)).inDays,
        withDiscount: withDiscount,
        onlyDiscount: onlyDiscount,
        isCalculateChildren: true,
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

  static double calculateTotalTariffRoom(
    RegistroTarifa? nowRegister,
    Habitacion habitacion,
    int totalDays, {
    bool isCalculateChildren = false,
    bool withDiscount = true,
    bool onlyDiscount = false,
    double? descuentoProvisional,
    bool onlyTariffVR = false,
    bool onlyTariffVPM = false,
    bool isGroupTariff = false,
    bool getTotalRoom = false,
  }) {
    double tariffAdult = 0;
    double tariffChildren = 0;

    if (nowRegister == null) {
      return 0;
    }

    if (nowRegister.tarifas == null) {
      return 0;
    }

    TarifaData? nowTarifa = nowRegister.tarifas!
        .where((element) => element.categoria == habitacion.categoria)
        .firstOrNull;

    if (onlyTariffVR) {
      nowTarifa = nowRegister.tarifas!
          .where((element) => element.categoria == tipoHabitacion.first)
          .firstOrNull;
    }

    if (onlyTariffVPM) {
      nowTarifa = nowRegister.tarifas!
          .where((element) => element.categoria == tipoHabitacion.last)
          .firstOrNull;
    }

    double descuento = 0;

    if (nowRegister.temporadas != null && nowRegister.temporadas!.isNotEmpty) {
      descuento = getSeasonNow(nowRegister, totalDays, isGroup: isGroupTariff)
              ?.porcentajePromocion ??
          0;
    } else {
      descuento = descuentoProvisional ?? 0;
    }

    tariffChildren =
        (nowTarifa?.tarifaMenores7a12 ?? 0) * habitacion.menores7a12!;

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
      tariffChildren = (tariffChildren - ((descuento / 100) * tariffChildren))
          .round()
          .toDouble();

      tariffAdult =
          (tariffAdult - ((descuento / 100) * tariffAdult)).round().toDouble();
    }

    if (onlyDiscount) {
      tariffChildren = ((descuento / 100) * tariffChildren).round().toDouble();
      tariffAdult = ((descuento / 100) * tariffAdult).round().toDouble();
    }

    if (getTotalRoom) {
      return (tariffChildren + tariffAdult);
    }

    if (isCalculateChildren) {
      return tariffChildren;
    } else {
      return tariffAdult;
    }
  }

  static TemporadaData? getSeasonNow(RegistroTarifa? nowRegister, int totalDays,
      {bool isGroup = false}) {
    if (nowRegister == null || nowRegister.temporadas == null) {
      return null;
    }

    TemporadaData? nowSeason;

    List<TemporadaData> validSeasons = [];

    validSeasons = nowRegister
            .copyWith()
            .temporadas
            ?.where((element) => (element.forGroup ?? false) == false)
            .toList()
            .map((element) => element.copyWith())
            .toList() ??
        [];

    if (isGroup) {
      validSeasons = nowRegister
              .copyWith()
              .temporadas
              ?.where((element) => (element.forGroup ?? false))
              .toList()
              .map((element) => element.copyWith())
              .toList() ??
          [];
    }

    for (var element in validSeasons) {
      if (totalDays == element.estanciaMinima ||
          totalDays > element.estanciaMinima!) {
        nowSeason = element.copyWith();
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
          forGroup: element.forGroup ?? false,
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

  static double calculateTotalRooms(
    List<Habitacion> habitaciones, {
    bool onlyTotalReal = false,
    bool onlyDiscount = false,
    bool onlyTotal = false,
    bool onlyFirstCategory = false,
    bool onlySecoundCategory = false,
    bool groupQuote = false,
  }) {
    double total = 0;

    List<Habitacion> realRooms =
        habitaciones.where((element) => !element.isFree).toList();
    List<Habitacion> rooms = realRooms;

    for (var element in rooms) {
      if (onlyTotalReal) {
        double subtotal = 0;

        if (groupQuote && element.tarifaGrupal != null) {
          if (onlyFirstCategory) {
            double subtotalCategory = calculateTotalTariffRoom(
              RegistroTarifa(
                temporadas: element.tarifaGrupal?.temporadas,
                tarifas: element.tarifaGrupal?.tarifas,
              ),
              element,
              element.tarifaXDia!.length,
              getTotalRoom: true,
              descuentoProvisional: element.tarifaGrupal?.descuentoProvisional,
              onlyTariffVR: true,
              isGroupTariff: true,
              withDiscount: false,
            );

            subtotal +=
                (subtotalCategory * element.tarifaXDia!.length) * element.count;
          }

          if (onlySecoundCategory) {
            double subtotalCategory = calculateTotalTariffRoom(
              RegistroTarifa(
                temporadas: element.tarifaGrupal?.temporadas,
                tarifas: element.tarifaGrupal?.tarifas,
              ),
              element,
              element.tarifaXDia!.length,
              getTotalRoom: true,
              descuentoProvisional: element.tarifaGrupal?.descuentoProvisional,
              onlyTariffVPM: true,
              isGroupTariff: true,
              withDiscount: false,
            );

            subtotal +=
                (subtotalCategory * element.tarifaXDia!.length) * element.count;
          }
        } else {
          if (!onlyFirstCategory && !onlySecoundCategory) {
            subtotal =
                ((element.totalRealVR ?? 0) + (element.totalRealVPM ?? 0)) *
                    element.count;
          }

          if (onlyFirstCategory) {
            subtotal = (element.totalRealVR ?? 0) * element.count;
          }

          if (onlySecoundCategory) {
            subtotal = (element.totalRealVPM ?? 0) * element.count;
          }
        }

        total += subtotal;
      }
      if (onlyDiscount) {
        double subtotal = 0;
        if (groupQuote && element.tarifaGrupal != null) {
          if (onlyFirstCategory) {
            double subtotalCategory = calculateTotalTariffRoom(
              RegistroTarifa(
                temporadas: element.tarifaGrupal?.temporadas,
                tarifas: element.tarifaGrupal?.tarifas,
              ),
              element,
              element.tarifaXDia!.length,
              getTotalRoom: true,
              descuentoProvisional: element.tarifaGrupal?.descuentoProvisional,
              onlyTariffVR: true,
              onlyDiscount: true,
              isGroupTariff: true,
              withDiscount: false,
            );

            subtotal +=
                (subtotalCategory * element.tarifaXDia!.length) * element.count;
          }

          if (onlySecoundCategory) {
            double subtotalCategory = calculateTotalTariffRoom(
              RegistroTarifa(
                temporadas: element.tarifaGrupal?.temporadas,
                tarifas: element.tarifaGrupal?.tarifas,
              ),
              element,
              element.tarifaXDia!.length,
              getTotalRoom: true,
              descuentoProvisional: element.tarifaGrupal?.descuentoProvisional,
              onlyTariffVPM: true,
              onlyDiscount: true,
              isGroupTariff: true,
              withDiscount: false,
            );

            subtotal +=
                (subtotalCategory * element.tarifaXDia!.length) * element.count;
          }
        } else {
          if (!onlyFirstCategory && !onlySecoundCategory) {
            subtotal =
                ((element.descuentoVR ?? 0) + (element.descuentoVPM ?? 0)) *
                    element.count;
          }

          if (onlyFirstCategory) {
            subtotal = (element.descuentoVR ?? 0) * element.count;
          }

          if (onlySecoundCategory) {
            subtotal = (element.descuentoVPM ?? 0) * element.count;
          }
        }

        total += subtotal;
      }
      if (onlyTotal) {
        double subtotal = 0;

        if (groupQuote && element.tarifaGrupal != null) {
          if (onlyFirstCategory) {
            double subtotalCategory = calculateTotalTariffRoom(
              RegistroTarifa(
                temporadas: element.tarifaGrupal?.temporadas,
                tarifas: element.tarifaGrupal?.tarifas,
              ),
              element,
              element.tarifaXDia!.length,
              getTotalRoom: true,
              descuentoProvisional: element.tarifaGrupal?.descuentoProvisional,
              onlyTariffVR: true,
              withDiscount: true,
              isGroupTariff: true,
            );

            subtotal +=
                (subtotalCategory * element.tarifaXDia!.length) * element.count;
          }

          if (onlySecoundCategory) {
            double subtotalCategory = calculateTotalTariffRoom(
              RegistroTarifa(
                temporadas: element.tarifaGrupal?.temporadas,
                tarifas: element.tarifaGrupal?.tarifas,
              ),
              element,
              element.tarifaXDia!.length,
              getTotalRoom: true,
              descuentoProvisional: element.tarifaGrupal?.descuentoProvisional,
              onlyTariffVPM: true,
              withDiscount: true,
              isGroupTariff: true,
            );

            subtotal +=
                (subtotalCategory * element.tarifaXDia!.length) * element.count;
          }
        } else {
          if (!onlyFirstCategory && !onlySecoundCategory) {
            subtotal = ((element.totalVR ?? 0) + (element.totalVPM ?? 0)) *
                element.count;
          }

          if (onlyFirstCategory) {
            subtotal = (element.totalVR ?? 0) * element.count;
          }

          if (onlySecoundCategory) {
            subtotal = (element.totalVPM ?? 0) * element.count;
          }
        }

        total += subtotal;
      }
    }

    if (onlyDiscount) {
      for (var element in habitaciones.where((element) => element.isFree)) {
        double subtotal = 0;

        if (groupQuote && element.tarifaGrupal != null) {
          if (onlyFirstCategory) {
            double subtotalCategory = calculateTotalTariffRoom(
              RegistroTarifa(
                temporadas: element.tarifaGrupal?.temporadas,
                tarifas: element.tarifaGrupal?.tarifas,
              ),
              element,
              element.tarifaXDia!.length,
              getTotalRoom: true,
              descuentoProvisional: element.tarifaGrupal?.descuentoProvisional,
              onlyTariffVR: true,
              withDiscount: true,
              isGroupTariff: true,
            );

            subtotal += (subtotalCategory * element.tarifaXDia!.length);
          }

          if (onlySecoundCategory) {
            double subtotalCategory = calculateTotalTariffRoom(
              RegistroTarifa(
                temporadas: element.tarifaGrupal?.temporadas,
                tarifas: element.tarifaGrupal?.tarifas,
              ),
              element,
              element.tarifaXDia!.length,
              getTotalRoom: true,
              descuentoProvisional: element.tarifaGrupal?.descuentoProvisional,
              onlyTariffVPM: true,
              withDiscount: true,
              isGroupTariff: true,
            );

            subtotal += (subtotalCategory * element.tarifaXDia!.length);
          }
        } else {
          if (!onlyFirstCategory && !onlySecoundCategory) {
            subtotal = ((element.totalVR ?? 0) + (element.totalVPM ?? 0)) *
                element.count;
          }

          if (onlyFirstCategory) {
            subtotal = (element.totalVR ?? 0) * element.count;
          }

          if (onlySecoundCategory) {
            subtotal = (element.totalVPM ?? 0) * element.count;
          }
        }

        total += subtotal;
      }
    }

    if (onlyTotal) {
      double desc = 0;
      for (var element in habitaciones.where((element) => element.isFree)) {
        double subtotal = 0;

        if (groupQuote && element.tarifaGrupal != null) {
          if (onlyFirstCategory) {
            double subtotalCategory = calculateTotalTariffRoom(
              RegistroTarifa(
                temporadas: element.tarifaGrupal?.temporadas,
                tarifas: element.tarifaGrupal?.tarifas,
              ),
              element,
              element.tarifaXDia!.length,
              getTotalRoom: true,
              descuentoProvisional: element.tarifaGrupal?.descuentoProvisional,
              onlyTariffVR: true,
              withDiscount: true,
              isGroupTariff: true,
            );

            subtotal += (subtotalCategory * element.tarifaXDia!.length);
          }

          if (onlySecoundCategory) {
            double subtotalCategory = calculateTotalTariffRoom(
              RegistroTarifa(
                temporadas: element.tarifaGrupal?.temporadas,
                tarifas: element.tarifaGrupal?.tarifas,
              ),
              element,
              element.tarifaXDia!.length,
              getTotalRoom: true,
              descuentoProvisional: element.tarifaGrupal?.descuentoProvisional,
              onlyTariffVPM: true,
              withDiscount: true,
              isGroupTariff: true,
            );

            subtotal += (subtotalCategory * element.tarifaXDia!.length);
          }
        } else {
          subtotal = ((element.totalVR ?? 0) + (element.totalVPM ?? 0)) *
              element.count;

          if (onlyFirstCategory) {
            subtotal = (element.totalVR ?? 0) * element.count;
          }

          if (onlySecoundCategory) {
            subtotal = (element.totalVPM ?? 0) * element.count;
          }
        }

        desc += subtotal;
      }

      total -= desc;
    }

    return total;
  }

  static double calculateTariffTotals(
    List<TarifaXDia> tarifasFiltradas,
    Habitacion habitacion, {
    bool onlyAdults = false,
    bool onlyChildren = false,
    bool onlyTariffVR = false,
    bool onlyTariffVPM = false,
  }) {
    double total = 0;

    for (var element in tarifasFiltradas) {
      TarifaData? selectTarifa = element.tarifa;

      if (onlyTariffVR) {
        selectTarifa = element.tarifas!
            .firstWhere((element) => element.categoria == tipoHabitacion.first);
      }

      if (onlyTariffVPM) {
        selectTarifa = element.tarifas!
            .firstWhere((element) => element.categoria == tipoHabitacion.last);
      }

      if (onlyAdults) {
        switch (habitacion.adultos) {
          case 1 || 2:
            total += (selectTarifa?.tarifaAdultoSGLoDBL ?? 0) * element.numDays;
            break;
          case 3:
            total += (selectTarifa?.tarifaAdultoTPL ?? 0) * element.numDays;
            break;
          case 4:
            total += (selectTarifa?.tarifaAdultoCPLE ?? 0) * element.numDays;
            break;
          default:
            total += 0;
        }
      }

      if (onlyChildren) {
        total += ((selectTarifa?.tarifaMenores7a12 ?? 0) * element.numDays) *
            (habitacion.menores7a12 ?? 0);
      }
    }

    return total;
  }

  static double calculateDiscountTotal(
    List<TarifaXDia> tarifasFiltradas,
    Habitacion habitacion,
    int totalDays, {
    bool onlyTariffVR = false,
    bool onlyTariffVPM = false,
  }) {
    double discountTotal = 0;

    for (var element in tarifasFiltradas) {
      discountTotal += calculateDiscountXTariff(
        element,
        habitacion,
        totalDays,
        onlyTariffVPM: onlyTariffVPM,
        onlyTariffVR: onlyTariffVR,
      );
    }

    return discountTotal;
  }

  static double calculateDiscountXTariff(
    TarifaXDia element,
    Habitacion habitacion,
    int totalDays, {
    bool onlyTariffVR = false,
    bool onlyTariffVPM = false,
  }) {
    double discount = 0;

    double totalAdults = Utility.calculateTotalTariffRoom(
      element.tarifa == null
          ? null
          : RegistroTarifa(
              tarifas: (onlyTariffVR || onlyTariffVPM)
                  ? element.tarifas
                  : [element.tarifa!],
              temporadas: element.temporadas ??
                  (element.temporadaSelect != null
                      ? [element.temporadaSelect!]
                      : []),
            ),
      habitacion,
      totalDays,
      withDiscount: false,
      onlyTariffVPM: onlyTariffVPM,
      onlyTariffVR: onlyTariffVR,
    );
    double totalChildren = Utility.calculateTotalTariffRoom(
      element.tarifa == null
          ? null
          : RegistroTarifa(
              tarifas: (onlyTariffVR || onlyTariffVPM)
                  ? element.tarifas
                  : [element.tarifa!],
              temporadas: element.temporadas ??
                  (element.temporadaSelect != null
                      ? [element.temporadaSelect!]
                      : []),
            ),
      habitacion,
      totalDays,
      withDiscount: false,
      onlyTariffVPM: onlyTariffVPM,
      onlyTariffVR: onlyTariffVR,
      isCalculateChildren: true,
    );

    double total = totalChildren + totalAdults;

    if (element.temporadaSelect != null) {
      discount =
          (total * 0.01) * (element.temporadaSelect?.porcentajePromocion ?? 0);
    } else {
      discount = (total * 0.01) * (element.descuentoProvisional ?? 0);
    }

    return (discount.round() * element.numDays) + 0.0;
  }

  static String intToRoman(int num) {
    final Map<int, String> romanMap = {
      1000: 'M',
      900: 'CM',
      500: 'D',
      400: 'CD',
      100: 'C',
      90: 'XC',
      50: 'L',
      40: 'XL',
      10: 'X',
      9: 'IX',
      5: 'V',
      4: 'IV',
      1: 'I',
    };

    StringBuffer result = StringBuffer();

    romanMap.forEach((value, symbol) {
      while (num >= value) {
        result.write(symbol);
        num -= value;
      }
    });

    return result.toString();
  }

  static List<TemporadaData> getSeasonsForPolitics(
    List<TemporadaData>? temporadasTarifa, {
    Politica? politicas,
    int rooms = 0,
  }) {
    List<TemporadaData> temporadas = [];

    if (politicas != null) {
      if (rooms >= politicas.limiteHabitacionCotizacion!) {
        temporadas = temporadasTarifa
                ?.where((element) => (element.forGroup ?? false))
                .toList()
                .map((element) => element.copyWith())
                .toList() ??
            [];
      } else {
        temporadas = temporadasTarifa
                ?.where((element) => (element.forGroup ?? false) == false)
                .toList()
                .map((element) => element.copyWith())
                .toList() ??
            [];
      }
    } else {
      temporadas = temporadasTarifa
              ?.where((element) => (element.forGroup ?? false) == false)
              .toList()
              .map((element) => element.copyWith())
              .toList() ??
          [];
    }

    return temporadas;
  }

  static List<String>? getPromocionesNoValidas(
    Habitacion habitacion, {
    required List<TemporadaData>? temporadas,
  }) {
    if (temporadas == null) return null;
    if (temporadas.isEmpty) return null;

    int totalEstancia = DateTime.parse(habitacion.fechaCheckOut!)
        .difference(DateTime.parse(habitacion.fechaCheckIn!))
        .inDays;

    List<String> promocionesNoValidas = [];

    for (var element in temporadas) {
      if (element.estanciaMinima! <= totalEstancia) {
        promocionesNoValidas.add(element.nombre);
      }
    }

    return promocionesNoValidas;
  }

  static List<String> getSeasonstoString(List<TemporadaData>? temporadas,
      {bool onlyGroups = false}) {
    List<String> seasons = [];
    if (temporadas != null) {
      for (var element in temporadas) {
        if (!onlyGroups && !(element.forGroup ?? false)) {
          seasons.add(element.nombre);
        } else if (onlyGroups && (element.forGroup ?? false)) {
          seasons.add(element.nombre);
        }
      }
    }

    return seasons;
  }

  static double applyDiscount(double priceTariff, double discountTariff) {
    double price = 0;
    double discount = 0;

    discount = (priceTariff * 0.01) * (discountTariff);
    price = priceTariff - discount;

    return price.round() + 0.0;
  }

  static bool revisedIntegrityRoom(
      Habitacion editRoom, List<Habitacion> habitaciones) {
    bool withoutChanges = false;

    Habitacion originalRoom = habitaciones.firstWhere(
        (element) => element.folioHabitacion == editRoom.folioHabitacion);

    if (originalRoom.fechaCheckIn != editRoom.fechaCheckIn ||
        originalRoom.fechaCheckOut != editRoom.fechaCheckOut) {
      withoutChanges = true;
    }

    return withoutChanges;
  }
}
