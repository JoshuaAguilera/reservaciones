import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cotizacion_model.dart';
import '../../models/estadistica_model.dart';
import '../../models/filter_model.dart';
import '../../models/reporte_cotizacion_model.dart';
import '../../res/helpers/date_helpers.dart';
import '../services/cotizacion_service.dart';
import '../../res/helpers/utility.dart';

final reporteCotizacionesIndProvider =
    FutureProvider.family<List<ReporteCotizacion>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final filterDate = ref.watch(filterReport);
  final date = ref.watch(dateReportProvider);

  final response = await CotizacionService().getList(
    initDate: DateHelpers.calculatePeriodReport(filter: filterDate, date: date),
    lastDate: DateHelpers.calculatePeriodReport(
      filter: filterDate,
      date: date,
      addTime: true,
    ),
    limit: 1000,
  );

  final list = Utility.getCotizacionQuotes(
    cotizaciones: response,
    filter: filterDate,
    date: date,
  );

  return list;
});

final cotizacionesDiariasProvider =
    FutureProvider.family<List<Estadistica>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  DateTime initDate = DateUtils.dateOnly(DateTime.now());
  final list = Utility.getDailyQuotesReport(
    respIndToday: await CotizacionService().getList(
      initDate: initDate,
      lastDate: DateTime.now(),
      limit: 100,
    ),
  );
  return list;
});

final ultimaCotizacionesProvider =
    FutureProvider.family<List<Cotizacion>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final list = await CotizacionService().getList();
  return list;
});

final allQuotesProvider =
    FutureProvider.family<List<Cotizacion>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final list = await CotizacionService().getList();
  return list;
});

final filtroDashboardProvider = StateProvider<String>((ref) => "Individual");

//Counts of quotes in dashboard
final statisticsQuoteProvider =
    FutureProvider.family<List<Estadistica>, List<Estadistica>>(
        (ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final filter = ref.watch(filtroDashboardProvider);
  final list = await CotizacionService().getCounts(stats: arg, filtro: filter);
  return list;
});

final changeProvider = StateProvider<int>((ref) => 0);

final filterReport = StateProvider<String>((ref) => "Semanal");

class DateReportNotifier extends StateNotifier<DateTime> {
  DateReportNotifier(DateTime initialDate) : super(initialDate);

  void changeDateView({
    required String typePeriod,
    bool isAfter = false,
  }) {
    final sign = isAfter ? 1 : -1;
    DateTime newDate = state;

    switch (typePeriod) {
      case "Semanal":
        newDate = state.add(Duration(days: 7 * sign));
        break;
      case "Mensual":
        int year = state.year;
        int month = state.month + sign;
        if (month < 1) {
          month = 12;
          year -= 1;
        } else if (month > 12) {
          month = 1;
          year += 1;
        }
        int day = state.day;
        int maxDay = DateTime(year, month + 1, 0).day;
        if (day > maxDay) day = maxDay;
        newDate = DateTime(year, month, day);
        break;
      case "Anual":
        int year = state.year + sign;
        int month = state.month;
        int day = state.day;
        int maxDay = DateTime(year, month + 1, 0).day;
        if (day > maxDay) day = maxDay;
        newDate = DateTime(year, month, day);
        break;
      default:
        return;
    }

    state = newDate;
  }
}

final dateReportProvider = StateNotifierProvider<DateReportNotifier, DateTime>(
  (ref) {
    final date =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    return DateReportNotifier(date);
  },
);

final filterQuoteDashProvider = StateProvider<Filter>((ref) {
  return Filter(
    layout: Layout.checkList,
    orderBy: OrderBy.antiguo,
    status: "",
  );
});
