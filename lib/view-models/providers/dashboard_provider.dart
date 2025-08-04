import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cotizacion_model.dart';
import '../../models/estadistica_model.dart';
import '../../models/list_helper_model.dart';
import '../../models/reporte_cotizacion_model.dart';
import '../../res/helpers/date_helpers.dart';
import '../services/cotizacion_service.dart';
import '../../res/helpers/utility.dart';
import 'usuario_provider.dart';

final reporteCotizacionesIndProvider =
    FutureProvider.family<List<ReporteCotizacion>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final filterDate = ref.watch(filterReport);
  final filter = ref.watch(filtroDashboardProvider);
  final date = ref.watch(dateReportProvider);
  final us = ref.watch(userProvider);

  final initDate = DateHelpers.calculatePeriodReport(
    filter: filterDate,
    date: date,
  );
  final lastDate = DateHelpers.calculatePeriodReport(
    filter: filterDate,
    date: date,
    addTime: true,
  );

  final response = await CotizacionService().getList(
    initDate: initDate,
    lastDate: lastDate,
    limit: 1000,
    creadorPor: filter == "Equipo" ? null : us,
  );

  final list = Utility.getCotizacionQuotes(
    cotizaciones: response,
    filter: filterDate,
    date: date,
    adminView: filter == "Equipo",
  );

  return list;
});

final cotizacionesDiariasProvider =
    FutureProvider.family<List<Estadistica>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final filter = ref.watch(filtroDashboardProvider);
  final us = ref.watch(userProvider);
  final now = DateTime.now();
  DateTime initDate = DateUtils.dateOnly(now);
  final list = Utility.getDailyQuotesReport(
    respIndToday: await CotizacionService().getList(
      initDate: initDate,
      lastDate: now,
      limit: 100,
      cerradorPor: filter == "Equipo" ? null : us,
    ),
  );
  return list;
});

final ultimaCotizacionesProvider =
    FutureProvider.family<List<Cotizacion>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final filter = ref.watch(filtroDashboardProvider);
  final us = ref.watch(userProvider);
  final list = await CotizacionService()
      .getList(creadorPor: filter == "Equipo" ? null : us);
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

final cotizaciones24hProvider =
    FutureProvider.family<Metrica, String>((ref, arg) async {
  final filter = ref.watch(filtroDashboardProvider);
  final us = ref.watch(userProvider);

  final metric = Metrica(
    title: "Cotizaciones Hoy",
    description: "Cotizaciones ayer:",
    initValue: 0,
    value: 0,
  );
  final now = DateTime.now();
  DateTime initDate = DateUtils.dateOnly(now);
  final pastDate = DateUtils.dateOnly(now.subtract(const Duration(days: 1)));

  final nowList = await CotizacionService().getList(
    initDate: initDate,
    lastDate: now,
    limit: 100,
    creadorPor: filter == "Equipo" ? null : us,
  );

  final pastList = await CotizacionService().getList(
    initDate: pastDate,
    lastDate: initDate,
    limit: 100,
  );

  metric.value = (nowList.length).toDouble();
  metric.initValue = (pastList.length).toDouble();

  return metric;
});

final cotizaciones7dProvider =
    FutureProvider.family<Metrica, String>((ref, arg) async {
  final filter = ref.watch(filtroDashboardProvider);
  final us = ref.watch(userProvider);

  final metric = Metrica(
    title: "Cotizaciones Semanales",
    description: "Periodo anterior:",
    initValue: 0,
    value: 0,
  );
  final now = DateTime.now();
  DateTime initDate =
      DateUtils.dateOnly(now).subtract(Duration(days: now.weekday - 1));
  final pastDate = DateUtils.dateOnly(now.subtract(const Duration(days: 7)));

  final nowList = await CotizacionService().getList(
    initDate: initDate,
    lastDate: now,
    limit: 1000,
    creadorPor: filter == "Equipo" ? null : us,
  );

  final pastList = await CotizacionService().getList(
    initDate: pastDate,
    lastDate: initDate.subtract(const Duration(days: 1)),
    limit: 1000,
    creadorPor: filter == "Equipo" ? null : us,
  );

  metric.value = (nowList.length).toDouble();
  metric.initValue = (pastList.length).toDouble();

  return metric;
});

final cotizaciones30dProvider =
    FutureProvider.family<Metrica, String>((ref, arg) async {
  final filter = ref.watch(filtroDashboardProvider);
  final us = ref.watch(userProvider);

  final metric = Metrica(
    title: "Cotizaciones 30 días",
    description: "Periodo anterior:",
    initValue: 0,
    value: 0,
  );
  final now = DateTime.now();
  DateTime initDate = DateTime(now.year, now.month, 1);
  final pastDate = DateTime(now.year, now.month - 1, 1);

  final nowList = await CotizacionService().getList(
    initDate: initDate,
    lastDate: now,
    limit: 1000,
    creadorPor: filter == "Equipo" ? null : us,
  );

  final pastList = await CotizacionService().getList(
    initDate: pastDate,
    lastDate: initDate.subtract(const Duration(days: 1)),
    limit: 1000,
    creadorPor: filter == "Equipo" ? null : us,
  );

  metric.value = (nowList.length).toDouble();
  metric.initValue = (pastList.length).toDouble();

  return metric;
});

final cotizaciones90dProvider =
    FutureProvider.family<Metrica, String>((ref, arg) async {
  final filter = ref.watch(filtroDashboardProvider);
  final us = ref.watch(userProvider);

  final metric = Metrica(
    title: "Cotizaciones 90 días",
    description: "Periodo anterior:",
    initValue: 0,
    value: 0,
  );
  final now = DateTime.now();
  DateTime initDate = DateTime(now.year, now.month - 2, 1);
  final pastDate = DateTime(now.year, now.month - 5, 1);

  final nowList = await CotizacionService().getList(
    initDate: initDate,
    lastDate: now,
    limit: 1000,
    creadorPor: filter == "Equipo" ? null : us,
  );

  final pastList = await CotizacionService().getList(
    initDate: pastDate,
    lastDate: initDate.subtract(const Duration(days: 1)),
    limit: 1000,
    creadorPor: filter == "Equipo" ? null : us,
  );

  metric.value = (nowList.length).toDouble();
  metric.initValue = (pastList.length).toDouble();

  return metric;
});
