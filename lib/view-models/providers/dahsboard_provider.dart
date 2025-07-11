import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cotizacion_model.dart';
import '../../models/numero_cotizacion_model.dart';
import '../../models/reporte_cotizacion_model.dart';
import '../../res/helpers/date_helpers.dart';
import '../services/cotizacion_service.dart';
import '../../res/helpers/utility.dart';

final reporteCotizacionesIndProvider =
    FutureProvider.family<List<ReporteCotizacion>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final filter = ref.watch(filterReport);
  final date = ref.watch(dateReport);

  final list = Utility.getCotizacionQuotes(
    cotizaciones: await CotizacionService().getList(
      initDate: DateHelpers.calculatePeriodReport(filter: filter, date: date),
      lastDate: DateHelpers.calculatePeriodReport(
          filter: filter, date: date, addTime: true),
    ),
    filter: filter,
    date: date,
  );
  return list;
});

final cotizacionesDiariasProvider =
    FutureProvider.family<List<NumeroCotizacion>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  DateTime initDate = DateUtils.dateOnly(DateTime.now());
  final list = Utility.getDailyQuotesReport(
    respIndToday: await CotizacionService()
        .getList(initDate: initDate, lastDate: DateTime.now()),
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

final changeProvider = StateProvider<int>((ref) {
  return 0;
});

final filterReport = StateProvider<String>((ref) {
  return "Semanal";
});

final dateReport = StateProvider<DateTime>((ref) {
  return DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
});
