import 'package:intl/intl.dart';

import '../../models/habitacion_model.dart';
import '../../models/periodo_model.dart';
import 'constants.dart';

class DateHelpers {
  static String getStringDate({
    DateTime? data,
    bool compact = false,
    bool onlyNameDate = false,
    bool withTime = false,
  }) {
    String date = "";

    if (!compact) {
      Intl.defaultLocale = "es_ES";
      DateTime nowDate = data ?? DateTime.now();
      DateFormat formatter = DateFormat('dd - MMMM - yyyy');
      date = formatter.format(nowDate);
      if (!onlyNameDate) {
        date = date.replaceAll(r'-', "de");
      } else {
        date = date.replaceAll(r'-', "/");
      }
    } else {
      DateTime nowDate = data ?? DateTime.now();
      DateFormat formatter = DateFormat('dd - MM - yy');
      date = formatter.format(nowDate);
      date = date.replaceAll(r'-', "/");
    }

    if (withTime) {
      DateFormat timeFormatter = DateFormat('HH:mm');
      String time = timeFormatter.format(data ?? DateTime.now());
      date += "  $time";
    }

    return date;
  }

  static String getCountDate(DateTime? date) {
    Duration time = DateTime.now().difference(date ?? DateTime.now());

    if (time.inDays >= 1) {
      return "${time.inDays} dia${time.inDays > 1 ? "s" : ""}";
    }

    if (time.inHours >= 1) {
      return "${time.inHours} hora${time.inHours > 1 ? "s" : ""}";
    }

    if (time.inMinutes >= 1) {
      return "${time.inMinutes} minuto${time.inMinutes > 1 ? "s" : ""}";
    }

    if (time.inSeconds >= 1) {
      return "${time.inSeconds} segundo${time.inSeconds > 1 ? "s" : ""}";
    }

    return "momento";
  }

  static String getPeriodReservation(List<Habitacion> rooms) {
    String period = "";
    Intl.defaultLocale = "es_ES";
    List<Habitacion> realQuotes =
        rooms.where((element) => !element.esCortesia).toList();

    if (realQuotes.length > 1) {
      List<String> dates = [];

      for (var element in realQuotes) {
        DateTime? initTime = element.checkIn;
        DateTime? lastTime = element.checkOut;
        DateFormat formatter = DateFormat('MMMM');

        if (lastTime?.month == initTime?.month) {
          dates.add("${initTime?.day} al ${getStringDate(data: lastTime)}");
        } else {
          dates.add(
              "${initTime?.day} de ${formatter.format(initTime ?? DateTime.now())} al ${getStringDate(data: lastTime)}");
        }
      }

      dates = dates.toSet().toList();

      for (String date in dates) {
        period += date;
        if (dates.last == date) period += ".";
        if (dates.last != date) period += ", ";
      }
    } else {
      DateTime? initTime = rooms.first.checkIn;
      DateTime? lastTime = rooms.first.checkOut;
      DateFormat formatter = DateFormat('MMMM');

      if (lastTime?.month == initTime?.month) {
        period += "${initTime?.day} al ${getStringDate(data: lastTime)}";
      } else {
        period +=
            "${initTime?.day} de ${formatter.format(initTime ?? DateTime.now())} al ${getStringDate(data: lastTime)}";
      }
    }

    return period;
  }

  static String getNextMonth(String text) {
    DateTime initDate = DateTime.tryParse(text) ?? DateTime.now();
    DateTime lastDate =
        DateTime(initDate.year, initDate.month + 1, initDate.day);

    return lastDate.toIso8601String().substring(0, 10);
  }

  static int getDifference(Habitacion room) {
    int days =
        room.checkOut?.difference(room.checkIn ?? DateTime.now()).inDays ?? 0;

    return days;
  }

  static DateTime calculatePeriodReport({
    required String filter,
    required DateTime date,
    bool addTime = false,
  }) {
    DateTime initPeriod = date;
    DateTime selectPeriod = date;

    switch (filter) {
      case "Semanal":
        int numDay = initPeriod.weekday;
        selectPeriod = addTime
            ? DateTime(
                initPeriod.add(const Duration(days: 6)).year,
                initPeriod.add(const Duration(days: 6)).month,
                initPeriod.add(const Duration(days: 6)).day,
                23,
                59,
                59,
              )
            : initPeriod.subtract(Duration(days: numDay - 1));
        break;
      case "Mensual":
        selectPeriod = addTime
            ? DateTime(initPeriod.year, (initPeriod.month + 1), 0, 23, 59, 59)
            : DateTime(initPeriod.year, initPeriod.month, 1);
        break;
      case "Anual":
        selectPeriod = addTime
            ? DateTime((initPeriod.year + 1), 1, 0, 23, 59, 59)
            : DateTime(initPeriod.year, 1, 1);
        break;
      default:
    }

    initPeriod = selectPeriod;

    return initPeriod;
  }

  static String getRangeDate(DateTime firstDate, DateTime lastDate) {
    String locale = 'es_ES';
    final monthFormat = DateFormat('MMMM', locale);

    final firstDay = firstDate.day;
    final lastDay = lastDate.day;

    final firstMonth = monthFormat.format(firstDate);
    final lastMonth = monthFormat.format(lastDate);

    final firstYear = firstDate.year;
    final lastYear = lastDate.year;

    if (firstYear == lastYear) {
      if (firstDate.month == lastDate.month) {
        return "$firstDay al $lastDay $firstMonth $firstYear";
      } else {
        return "$firstDay $firstMonth al $lastDay $lastMonth $firstYear";
      }
    } else {
      return "$firstDay $firstMonth $firstYear al $lastDay $lastMonth $lastYear";
    }
  }

  static String defineMonthPeriod(String initDay, String lastDay) {
    String locale = 'es_ES';
    final monthFormat = DateFormat('MMMM', locale);

    String period = "";
    DateTime? dataInit = DateTime.parse(initDay);
    DateTime? dataLast = DateTime.parse(lastDay);

    if (dataInit.month == dataLast.month) {
      period = monthFormat.format(dataInit);
    } else {
      period =
          "${monthFormat.format(dataInit)} - ${monthFormat.format(dataLast)}";
    }

    return period;
  }

  static bool revisedLimit(DateTime checkIn, DateTime checkOut) {
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

  static String definePeriodNow(
    DateTime weekNow, {
    List<Periodo>? periodos,
    bool compact = false,
  }) {
    String periodo = "01 Enero a 14 Marzo";
    Periodo periodNow = getPeriodNow(weekNow, periodos);
    periodo = getStringPeriod(
      initDate: periodNow.fechaInicial!,
      lastDate: periodNow.fechaFinal!,
      compact: compact,
    );

    return periodo;
  }

  static String getStringPeriod({
    required DateTime initDate,
    required DateTime lastDate,
    bool compact = true,
  }) {
    String locale = 'es_ES';
    final nowYear = DateTime.now().year;
    final firstDay = initDate.day;
    final lastDay = lastDate.day;
    final firstYear = initDate.year;
    final lastYear = lastDate.year;

    String formatMonth(DateTime date) {
      final month = DateFormat('MMMM', locale).format(date);
      final shortMonth = compact ? month.substring(0, 3) : month;
      return '${shortMonth[0].toUpperCase()}${shortMonth.substring(1)}';
    }

    String yearSuffix(int year) {
      return nowYear != year ? ' $year' : '';
    }

    final firstMonth = formatMonth(initDate);
    final lastMonth = formatMonth(lastDate);

    if (initDate.isAtSameMomentAs(lastDate)) {
      return '$lastDay $lastMonth${yearSuffix(firstYear)}';
    }

    if (firstYear == lastYear) {
      if (initDate.month == lastDate.month) {
        return '$firstDay - $lastDay $lastMonth${yearSuffix(firstYear)}';
      } else {
        return '$firstDay $firstMonth - $lastDay $lastMonth${yearSuffix(firstYear)}';
      }
    } else {
      return compact
          ? '$firstDay/${initDate.month}/${firstYear.toString().substring(2)} - $lastDay/${lastDate.month}/${lastYear.toString().substring(2)}'
          : '$firstDay $firstMonth $firstYear - $lastDay $lastMonth $lastYear';
    }
  }

  static Periodo getPeriodNow(DateTime weekNow, List<Periodo>? periodos) {
    Periodo dataNow = Periodo();

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

  static List<DateTime> generateSegmentWeek(DateTime weekNow) {
    return List.generate(7, (index) {
      final day = weekNow.add(Duration(days: index));
      return DateTime(day.year, day.month, day.day);
    });
  }

  static DateTime getInitWeekOfMonth(DateTime initWeekMonth, int weekIndex) {
    if (weekIndex == 0) {
      return initWeekMonth.subtract(Duration(days: initWeekMonth.weekday - 1));
    } else {
      final daysOffset =
          (7 - initWeekMonth.weekday + 1) + ((weekIndex - 1) * 7);
      return initWeekMonth.add(Duration(days: daysOffset));
    }
  }

  static int getWeeksInMonth(DateTime monthDate) {
    final year = monthDate.year;
    final month = monthDate.month;

    final totalDays = DateTime(year, month + 1, 0).day;
    final firstWeekday = DateTime(year, month, 1).weekday;
    final lastWeekday = DateTime(year, month + 1, 0).weekday;

    final totalCells = totalDays + (firstWeekday - 1) + (7 - lastWeekday);

    return totalCells <= 35 ? 5 : 6;
  }

  static String getWeekDays(List<String>? weekDays) {
    String days = "";

    for (var element in weekDays ?? <String>[]) {
      days +=
          "${element.substring(0, 1).toUpperCase()}${element.substring(1, 2).toLowerCase()} ";
    }

    return days.trim();
  }

  static String getPeriodSelect(
    String typePeriod,
    DateTime selectTime,
  ) {
    String period = '';
    DateTime startWeek =
        selectTime.subtract(Duration(days: selectTime.weekday - 1));

    switch (typePeriod) {
      case "Semanal":
        period = DateHelpers.getRangeDate(
          startWeek,
          startWeek.add(const Duration(days: 6)),
        );
      case "Mensual":
        period = "${monthNames[selectTime.month - 1]} ${selectTime.year}";
      case "Anual":
        period = selectTime.year.toString();
      default:
        period = "Unknow";
    }

    return period;
  }
}

extension DateValueFormat on DateTime {
  static DateTime? fromJSON(dynamic value) {
    return value is int
        ? DateTime.fromMillisecondsSinceEpoch(
            value * 1000,
            isUtc: true,
          )
        : value is String
            ? DateTime.tryParse(value)
            : null;
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[month - 1];
  }

  static DateTime getStartOfWeek(DateTime monthStart, int weekIndex) {
    final firstWeekStart =
        monthStart.subtract(Duration(days: monthStart.weekday - 1));

    return firstWeekStart.add(Duration(days: weekIndex * 7));
  }
}
