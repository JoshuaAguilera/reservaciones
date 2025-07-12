import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/res/helpers/date_helpers.dart';
import 'package:intl/intl.dart';

import '../../models/cotizacion_model.dart';
import '../../models/habitacion_model.dart';
import '../../models/numero_cotizacion_model.dart';
import '../../models/periodo_model.dart';
import '../../models/politica_tarifario_model.dart';
import '../../models/reporte_cotizacion_model.dart';
import '../../models/tarifa_model.dart';
import '../../models/tarifa_rack_model.dart';
import '../../models/tarifa_x_habitacion_model.dart';
import '../../models/temporada_model.dart';
import '../../utils/shared_preferences/preferences.dart';
import '../ui/text_styles.dart';
import 'calculator_helpers.dart';
import 'constants.dart';

class Utility {
  static String getTitleByIndex(int index) {
    final indices = {
      0: 'Inicio',
      1: 'Generar Cotización',
      2: 'Historial',
      3: 'Configuración',
      4: 'Tarifario',
      5: 'Gestión de usuarios',
      6: 'Clientes',
      12: 'Detalle comprobante',
      15: 'Gestión de tarifa',
      16: 'Gestión de habitación',
      99: 'Perfil',
    };

    String? title = indices[index];
    return title ?? 'Not found page';
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

  static bool isResizable({
    required bool extended,
    required BuildContext context,
    double minWidth = 700,
    double minWidthWithBar = 725,
  }) {
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
    List<Cotizacion>? cotizaciones,
    required String filter,
    required DateTime date,
  }) {
    List<ReporteCotizacion> listCot = [];
    DateTime now = date;

    switch (filter) {
      case "Semanal":
        try {
          for (var i = 1; i < 8; i++) {
            ReporteCotizacion quoteDay = ReporteCotizacion(
              numCotizacionesGrupales: 0,
              numCotizacionesIndividual: 0,
              numReservacionesGrupales: 0,
              numReservacionesIndividual: 0,
            );

            if (cotizaciones != null) {
              List<Cotizacion> quotesInd = cotizaciones
                  .where((element) => element.createdAt?.weekday == i)
                  .toList();

              for (var element in quotesInd) {
                if (element.esGrupo!) {
                  if (element.estatus == "reservado") {
                    quoteDay.numReservacionesGrupales++;
                  } else {
                    quoteDay.numCotizacionesGrupales++;
                  }
                } else {
                  if (element.estatus == "reservado") {
                    quoteDay.numReservacionesIndividual++;
                  } else {
                    quoteDay.numCotizacionesIndividual++;
                  }
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
            numReservacionesGrupales: 0,
            numReservacionesIndividual: 0,
          );

          if (cotizaciones != null) {
            List<Cotizacion> quotes = cotizaciones
                .where((element) => element.createdAt?.day == i)
                .toList();

            for (var element in quotes) {
              if (element.esGrupo!) {
                if (element.estatus == "reservado") {
                  quoteDay.numReservacionesGrupales++;
                } else {
                  quoteDay.numCotizacionesGrupales++;
                }
              } else {
                if (element.estatus == "reservado") {
                  quoteDay.numReservacionesIndividual++;
                } else {
                  quoteDay.numCotizacionesIndividual++;
                }
              }
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
            numReservacionesGrupales: 0,
            numReservacionesIndividual: 0,
          );

          if (cotizaciones != null) {
            List<Cotizacion> quotes = cotizaciones
                .where((element) => element.createdAt?.month == i)
                .toList();

            for (var element in quotes) {
              if (element.esGrupo!) {
                if (element.estatus == "reservado") {
                  quoteDay.numReservacionesGrupales++;
                } else {
                  quoteDay.numCotizacionesGrupales++;
                }
              } else {
                if (element.estatus == "reservado") {
                  quoteDay.numReservacionesIndividual++;
                } else {
                  quoteDay.numCotizacionesIndividual++;
                }
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
        firstDayNextMonth.subtract(const Duration(days: 1));

    return lastDayCurrentMonth.day;
  }

  static List<NumeroCotizacion> getDailyQuotesReport(
      {List<Cotizacion>? respIndToday}) {
    List<NumeroCotizacion> cot = [];

    NumeroCotizacion cotizacionesTotales =
        NumeroCotizacion(tipoCotizacion: "Total");

    NumeroCotizacion cotizacionesGrupales =
        NumeroCotizacion(tipoCotizacion: "Grupales");

    NumeroCotizacion cotizacionesIndividuales =
        NumeroCotizacion(tipoCotizacion: "Individuales");

    NumeroCotizacion reservadas =
        NumeroCotizacion(tipoCotizacion: "Reservadas");

    NumeroCotizacion cotizacionesNoConcretadas =
        NumeroCotizacion(tipoCotizacion: "Caducadas");

    for (var element in respIndToday ?? List<Cotizacion>.empty()) {
      if (DateTime.now().compareTo(element.fechaLimite ?? DateTime.now()) ==
              1 &&
          (element.estatus != "reservado")) {
        cotizacionesNoConcretadas.numCotizaciones++;

        continue;
      }

      if (element.estatus == "reservado") {
        reservadas.numCotizaciones++;
      }

      if (element.esGrupo ?? false) {
        cotizacionesGrupales.numCotizaciones++;
      } else {
        cotizacionesIndividuales.numCotizaciones++;
      }
    }

    cot.addAll([
      cotizacionesTotales,
      cotizacionesGrupales,
      cotizacionesIndividuales,
      reservadas,
      cotizacionesNoConcretadas,
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

  static List<Widget> generateTextWidget(
      List<String> list, Color? primaryColor) {
    List<Widget> children = [];

    for (var element in list) {
      children.add(TextStyles.standardText(text: element, color: primaryColor));
    }

    return children;
  }

  static double formatNumberRound(double number, {int fractionDigits = 7}) {
    if (number > 0) {
      return double.parse(number.toStringAsFixed(fractionDigits));
    } else if (number < 0) {
      return double.parse(number.toStringAsFixed(fractionDigits));
    } else {
      return 0.0;
    }
  }

  static bool showTariffByWeek(
      List<Periodo>? periodos, DateTime initDayWeekGraphics) {
    bool show = false;
    if (periodos == null || periodos.isEmpty) return show;

    DateTime lastDayWeek = initDayWeekGraphics.add(const Duration(days: 6));

    for (var period in periodos) {
      final start = period.fechaInicial!;
      final end = period.fechaFinal!;

      final bool overlaps =
          !(end.isBefore(initDayWeekGraphics) || start.isAfter(lastDayWeek));

      if (overlaps) return true;
    }

    return show;
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

  static bool defineApplyDays(Periodo nowPeriod, DateTime element) {
    final weekdayMap = {
      1: 'Lunes',
      2: 'Martes',
      3: 'Miercoles',
      4: 'Jueves',
      5: 'Viernes',
      6: 'Sabado',
      7: 'Domingo',
    };

    final dayName = weekdayMap[element.weekday];
    if (dayName == null) return false;

    final isActiveDay =
        nowPeriod.diasActivo?.any((day) => day.contains(dayName)) ?? false;

    return !isActiveDay;
  }

  static bool isWeekdayActive(String weekday, Periodo period) {
    final activeDays = period.diasActivo;
    if (activeDays == null || activeDays.isEmpty) return false;

    return activeDays.any((day) => day == weekday);
  }

  static double getExpandedDayWeek(
      double sectionDay, Periodo nowPeriod, DateTime element) {
    final weekday = element.weekday;
    if (weekday < 1 || weekday > 7) return 0;

    final List<String> weekdays = [
      'Lunes',
      'Martes',
      'Miercoles',
      'Jueves',
      'Viernes',
      'Sabado',
      'Domingo',
    ];

    double flex = 0;
    final startIndex = weekday - 1;
    final activeDays = nowPeriod.diasActivo ?? [];

    for (int i = startIndex; i < weekdays.length; i++) {
      final dayName = weekdays[i];

      final targetDate = element.add(Duration(days: i - startIndex));

      if (!getLimitDaysInWeek(targetDate, nowPeriod.fechaFinal!)) break;

      if (activeDays.contains(dayName)) {
        flex += sectionDay;
      } else {
        break;
      }
    }

    return flex;
  }

  static bool getLimitDaysInWeek(DateTime initDate, DateTime lastDate) {
    return initDate.compareTo(lastDate) < 0;
  }

  static String defineStatusPeriod(Periodo nowPeriod) {
    final nowDate = DateTime.now();
    final today = DateTime(nowDate.year, nowDate.month, nowDate.day);

    final start = nowPeriod.fechaInicial!;
    final end = nowPeriod.fechaFinal!;

    if (today.isAtSameMomentAs(end)) return "TERMINA HOY";
    if (today.isBefore(start)) return "VIGENTE";
    if (today.isAfter(end)) return "TERMINADA";

    return "EN PROCESO";
  }

  static double calculatePercentagePeriod(Periodo nowPeriod) {
    final start = nowPeriod.fechaInicial!;
    final end = nowPeriod.fechaFinal!;
    final today = DateTime.now();

    final totalDays = end.difference(start).inDays + 1;
    final elapsedDays = today.difference(start).inDays;

    final rawPercentage = (elapsedDays / totalDays) * 100;

    return rawPercentage.clamp(0, 100);
  }

  static bool getRevisedActually(Periodo nowPeriod) {
    final today = DateTime.now();
    final currentDate = DateTime(today.year, today.month, today.day);

    final start = nowPeriod.fechaInicial!;
    final end = nowPeriod.fechaFinal!;

    return currentDate.isAfter(start) && currentDate.isAfter(end);
  }

  static bool showTariffNow(
    DateTime nowDay,
    List<Periodo>? periodos,
  ) {
    if (periodos == null || periodos.isEmpty) return false;

    final currentDate = DateTime(nowDay.year, nowDay.month, nowDay.day);

    Periodo? activePeriod = periodos.where((period) {
      final start = period.fechaInicial!;
      final end = period.fechaFinal!;
      return (currentDate.isAfter(start) ||
              currentDate.isAtSameMomentAs(start)) &&
          (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end));
    }).firstOrNull;

    if (activePeriod == null) return false;

    final weekdays = [
      'Lunes',
      'Martes',
      'Miercoles',
      'Jueves',
      'Viernes',
      'Sabado',
      'Domingo',
    ];

    final activeDays = activePeriod.diasActivo ?? [];
    final startIndex = currentDate.weekday - 1;

    // ignore: dead_code
    for (int i = startIndex; i < weekdays.length; i++) {
      if (activeDays.contains(weekdays[i])) {
        return true;
      } else {
        break;
      }
    }

    return false;
  }

  static TarifaRack? revisedTariffDay(
    DateTime daySelect,
    List<TarifaRack> list,
  ) {
    TarifaRack? first;
    TarifaRack? rateFound;

    rateFound = list
        .where((rate) =>
            rate.periodos?.any(
              (element) => ((daySelect.compareTo(element.fechaInicial!) == 0 &&
                      daySelect.compareTo(element.fechaFinal!) == 0) &&
                  element.fechaInicial!.isSameDate(element.fechaFinal!)),
            ) ??
            false)
        .firstOrNull;

    if (rateFound != null) return rateFound;

    first = list
        .where((element) => showTariffNow(daySelect, element.periodos))
        .firstOrNull;

    if (first == null) {
      return first;
    } else {
      return first.copyWith();
    }
  }

  //V2 Found rates

  // static List<TarifaRack?> revisedTariffDay2(
  //     DateTime daySelect, List<TarifaRack> list) {
  //   List<RegistroTarifa>? first;

  //   if (list.any((element) => element.periodos!.any((element) =>
  //       ((daySelect.compareTo(element.fechaInicial!) == 0 &&
  //               daySelect.compareTo(element.fechaFinal!) == 0) &&
  //           element.fechaInicial!.isSameDate(element.fechaFinal!))))) {
  //     return list
  //         .where((element) => element.periodos!.any((element) =>
  //             ((daySelect.compareTo(element.fechaInicial!) == 0 &&
  //                     daySelect.compareTo(element.fechaFinal!) == 0) &&
  //                 element.fechaInicial!.isSameDate(element.fechaFinal!))))
  //         .toList();
  //   }

  //   first = list
  //       .where((element) => showTariffNow(daySelect, element.periodos))
  //       .toList();

  //   if (first.isEmpty) {
  //     return [];
  //   } else {
  //     return first.map((e) => e.copyWith()).toList();
  //   }
  // }

  static List<Periodo> getPeriodsRegister(List<Periodo>? periods) {
    List<Periodo> periodos = [];

    for (var element in periods!) {
      Periodo periodNow = Periodo(
          fechaFinal: element.fechaFinal, fechaInicial: element.fechaInicial);
      periodos.add(periodNow);
    }

    return periodos;
  }

  static String defineStatusTariff(List<Periodo>? periodos) {
    if (periodos == null || periodos.isEmpty) return "En proceso";
    final allFinished = periodos.every(getRevisedActually);
    return allFinished ? "Terminada" : "En proceso";
  }

  static List<TarifaXHabitacion> getUniqueTariffs(
      List<TarifaXHabitacion> list) {
    List<TarifaXHabitacion> tarifasFiltradas = [];
    tarifasFiltradas.clear();

    for (var element in list) {
      bool tariff = tarifasFiltradas
          .any((elementInt) => elementInt.idInt == element.idInt);

      if (!tariff) {
        tarifasFiltradas.add(element.copyWith());
      } else {
        if (element.subcode == null) {
          if (tariff) {
            TarifaXHabitacion? tarifaNow = tarifasFiltradas
                .where((elementInt) =>
                    elementInt.id == element.id && elementInt.subcode == null)
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
          TarifaXHabitacion? tariffMod = tarifasFiltradas
              .where((elementInt) =>
                  (elementInt.idInt == element.idInt) &&
                  elementInt.subcode == element.subcode)
              .firstOrNull;

          if (tariffMod != null) {
            tariffMod.numDays++;
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
      if (element.esCortesia) {
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

  static List<Temporada> getSeasonsForPolitics(
    List<Temporada>? temporadasTarifa, {
    PoliticaTarifario? politicas,
    int rooms = 0,
  }) {
    List<Temporada> temporadas = [];

    if (politicas != null) {
      if (rooms >= politicas.valor) {
        temporadas = temporadasTarifa
                ?.where((element) => (element.tipo == "grupal"))
                .toList()
                .map((element) => element.copyWith())
                .toList() ??
            [];
      } else {
        temporadas = temporadasTarifa
                ?.where((element) => (element.tipo == "individual"))
                .toList()
                .map((element) => element.copyWith())
                .toList() ??
            [];
      }
    } else {
      temporadas = temporadasTarifa
              ?.where((element) => (element.tipo == "individual"))
              .toList()
              .map((element) => element.copyWith())
              .toList() ??
          [];
    }

    return temporadas;
  }

  static List<String>? getPromocionesNoValidas(Habitacion habitacion,
      {required List<Temporada>? temporadas}) {
    if (temporadas == null) return null;
    if (temporadas.isEmpty) return null;

    int totalEstancia =
        habitacion.checkOut?.difference(habitacion.checkIn!).inDays ?? 0;

    List<String> promocionesNoValidas = [];

    for (var element in temporadas) {
      if (element.estanciaMinima! <= totalEstancia) {
        promocionesNoValidas.add(element.nombre ?? '');
      }
    }

    return promocionesNoValidas;
  }

  static List<String> getSeasonstoString(List<Temporada>? temporadas,
      {String tipo = "individual"}) {
    List<String> seasons = [];
    if (temporadas != null) {
      for (var element in temporadas) {
        if (element.tipo == tipo) seasons.add(element.nombre ?? '');
      }

      if (seasons.isEmpty && tipo != "individual") {
        for (var element in temporadas) {
          if (!(element.tipo == tipo)) {
            seasons.add(element.nombre ?? '');
          }
        }
      }
    }

    return seasons;
  }

  static bool revisedIntegrityRoom(
      Habitacion editRoom, List<Habitacion> habitaciones) {
    bool withoutChanges = false;

    Habitacion originalRoom =
        habitaciones.firstWhere((element) => element.id == editRoom.id);

    if (originalRoom.checkIn != editRoom.checkIn ||
        originalRoom.checkOut != editRoom.checkOut) {
      withoutChanges = true;
    }

    return withoutChanges;
  }

  static int getUniqueCode() {
    String code = "";
    DateTime nowDate = DateTime.now();

    code = nowDate.toString().substring(2, 20).replaceAll(RegExp(r'-'), '');
    code = code.toString().replaceAll(RegExp(r'[.]'), '');
    code = code.toString().replaceAll(RegExp(r':'), '');
    code = code.toString().replaceAll(RegExp(r' '), '');

    return int.parse("$code${Preferences.userIdInt}");
  }

  static bool revisedPropiertiesSaveTariff(Tarifa? saveTariff) {
    if (saveTariff?.tarifaAdulto1a2 == null) return true;
    if (saveTariff?.tarifaAdulto3 == null) return true;
    if (saveTariff?.tarifaAdulto4 == null) return true;
    if (saveTariff?.tarifaPaxAdicional == null) return true;
    if (saveTariff?.tarifaMenores7a12 == null) return true;

    return false;
  }

  static List<Tarifa> getTarifasData(List<Tarifa?> list,
      {bool withRound = false}) {
    List<Tarifa> tarifas = [];

    for (var element in list) {
      if (withRound) {
        Tarifa? tarifaRound = getRoundTariff(element);
        if (tarifaRound == null) continue;
        tarifas.add(tarifaRound);
      } else {
        if (element == null) continue;
        tarifas.add(element);
      }
    }

    return tarifas;
  }

  static Tarifa? getRoundTariff(Tarifa? tariff) {
    Tarifa? roundTariff;

    roundTariff = tariff?.copyWith();

    roundTariff?.tarifaAdulto1a2 = CalculatorHelpers.getPromotion(
      tariff?.tarifaAdulto1a2,
      returnDouble: true,
    );

    roundTariff?.tarifaAdulto3 = CalculatorHelpers.getPromotion(
      tariff?.tarifaAdulto3,
      returnDouble: true,
    );

    roundTariff?.tarifaAdulto4 = CalculatorHelpers.getPromotion(
      tariff?.tarifaAdulto4,
      returnDouble: true,
    );

    roundTariff?.tarifaMenores7a12 = CalculatorHelpers.getPromotion(
      tariff?.tarifaMenores7a12,
      returnDouble: true,
    );

    roundTariff?.tarifaMenores0a6 = CalculatorHelpers.getPromotion(
      tariff?.tarifaMenores0a6,
      returnDouble: true,
    );

    roundTariff?.tarifaPaxAdicional = CalculatorHelpers.getPromotion(
      tariff?.tarifaPaxAdicional,
      returnDouble: true,
    );

    return roundTariff;
  }

  static double getFileSizeMB(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

  static Temporada? getSeasonNow({
    TarifaRack? rack,
    required int totalDays,
    String tipo = "individual",
  }) {
    if (rack == null || rack.temporadas == null) {
      return null;
    }

    Temporada? nowSeason;

    List<Temporada> validSeasons = [];

    validSeasons = rack
            .copyWith()
            .temporadas
            ?.where(
                (element) => element.tipo?.toLowerCase() == tipo.toLowerCase())
            .toList()
            .map((element) => element.copyWith())
            .toList() ??
        [];

    for (var element in validSeasons) {
      if (totalDays == element.estanciaMinima ||
          totalDays > element.estanciaMinima!) {
        nowSeason = element.copyWith();
      }
    }

    return nowSeason;
  }
}
