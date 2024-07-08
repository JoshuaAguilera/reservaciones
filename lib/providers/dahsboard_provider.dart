import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/reporte_Cotizacion_model.dart';
import 'package:tuple/tuple.dart';

import '../database/database.dart';
import '../models/cotizacion_diaria_model.dart';
import '../services/comprobante_service.dart';
import '../services/cotizacion_service.dart';
import '../utils/helpers/utility.dart';

final reporteCotizacionesProvider =
    FutureProvider.family<List<ReporteCotizacion>, Tuple2<String, dynamic>>(
        (ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final list = Utility.getReportQuotes(await CotizacionService()
      .getCotizacionesTimePeriod(
          DateTime.now().subtract(const Duration(days: 7)), DateTime.now()));
  return list;
});

final cotizacionesDiariasProvider =
    FutureProvider.family<List<CotizacionDiaria>, Tuple2<String, dynamic>>(
        (ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final list = Utility.getDailyQuotesReport(
      await CotizacionService().getCotizacionesActuales());
  return list;
});

final ultimaCotizacionesProvider =
    FutureProvider.family<List<ReceiptQuoteData>, Tuple2<String, dynamic>>(
        (ref, arg) async {
  final detectChanged = ref.watch(changeProvider);
  final list = await ComprobanteService().getComprobantesRecientes();
  return list;
});

final changeProvider = StateProvider<int>((ref) {
  return 0;
});
