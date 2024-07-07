import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';
import 'package:tuple/tuple.dart';

import '../models/cotizacion_diaria_model.dart';
import '../services/cotizacion_service.dart';
import '../utils/helpers/utility.dart';

final reporteCotizacionesProvider =
    FutureProvider.family<List<ReporteCotizacion>, Tuple2<String, dynamic>>(
        (ref, arg) async {
  final list = Utility.getReportQuotes(await CotizacionService()
      .getCotizacionesTimePeriod(
          DateTime.now().subtract(const Duration(days: 7)), DateTime.now()));

  return list;
});

final cotizacionesDiariasProvider =
    FutureProvider.family<List<CotizacionDiaria>, Tuple2<String, dynamic>>(
        (ref, arg) async {
  final list = Utility.getDailyQuotesReport(
      await CotizacionService().getCotizacionesActuales());

  return list;
});
