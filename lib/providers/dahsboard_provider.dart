import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';

import '../database/database.dart';
import '../models/numero_cotizacion_model.dart';
import '../services/cotizacion_service.dart';
import '../utils/helpers/utility.dart';

final reporteCotizacionesIndProvider =
    FutureProvider.family<List<ReporteCotizacion>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final filter = ref.watch(filterReport);
  final date = ref.watch(dateReport);

  final list = Utility.getCotizacionQuotes(
    cotizaciones: await CotizacionService().getCotizacionesTimePeriod(
      Utility.calculatePeriodReport(filter, date),
      Utility.calculatePeriodReport(filter, date, addTime: true),
    ),
    filter: filter,
    date: date,
  );
  return list;
});

final cotizacionesDiariasProvider =
    FutureProvider.family<List<NumeroCotizacion>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final list = Utility.getDailyQuotesReport(
      respIndToday: await CotizacionService().getCotizacionesActuales());
  return list;
});

final ultimaCotizacionesProvider =
    FutureProvider.family<List<CotizacionData>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final list = await CotizacionService().getCotizacionesRecientes();
  return list;
});

final allQuotesProvider =
    FutureProvider.family<List<CotizacionData>, String>((ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final list = await CotizacionService().getCotizaciones();
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
