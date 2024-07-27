import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';
import 'package:tuple/tuple.dart';

import '../database/database.dart';
import '../models/numero_cotizacion_model.dart';
import '../services/comprobante_service.dart';
import '../services/cotizacion_service.dart';
import '../utils/helpers/utility.dart';

final reporteCotizacionesIndProvider =
    FutureProvider.family<List<ReporteCotizacion>, Tuple2<String, dynamic>>(
        (ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final filter = ref.watch(filterReport);
  final list = Utility.getReportQuotes(
    cotizacionesInd: await CotizacionService().getCotizacionesIndTimePeriod(
        Utility.calculatePeriodReport(filter), DateTime.now()),
    filter: filter,
    cotizacionesGroup: await CotizacionService().getCotizacionesGroupTimePeriod(
        Utility.calculatePeriodReport(filter), DateTime.now()),
  );
  return list;
});

final cotizacionesDiariasProvider =
    FutureProvider.family<List<NumeroCotizacion>, Tuple2<String, dynamic>>(
        (ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final list = Utility.getDailyQuotesReport(
      respIndToday: await CotizacionService().getCotizacionesIndActuales(),
      respGroupToday: await CotizacionService().getCotizacionesGroupActuales());
  return list;
});

final ultimaCotizacionesProvider =
    FutureProvider.family<List<ReceiptQuoteData>, Tuple2<String, dynamic>>(
        (ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final list = await ComprobanteService().getComprobantesRecientes();
  return list;
});

final allQuotesProvider =
    FutureProvider.family<List<NumeroCotizacion>, Tuple2<String, dynamic>>(
        (ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final list = await Utility.getDailyQuotesReport(
      respIndToday: await CotizacionService().getAllQuoteInd(),
      respGroupToday: await CotizacionService().getAllQuoteGroup());
  return list;
});

final changeProvider = StateProvider<int>((ref) {
  return 0;
});

final filterReport = StateProvider<String>((ref) {
  return "Semanal";
});
