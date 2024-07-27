import 'package:generador_formato/models/cotizacion_grupal_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/comprobante_cotizacion_model.dart';
import '../models/cotizacion_model.dart';
import '../services/generador_doc_service.dart';
import '../utils/helpers/constants.dart';

final documentQuoteIndProvider =
    FutureProvider.family<pw.Document, String>((ref, arg) async {
  final detectChanged = ref.watch(changeDocIndProvider);
  final themeDefault = ref.watch(themeDefaultIndProvider);

  pw.Document comprobantePDF =
      await GeneradorDocService().generarComprobanteCotizacionIndividual(
    cotizacionesInd: [
      Cotizacion(
        adultos: 1,
        categoria: categorias.first,
        plan: planes.first,
        tarifaRealAdulto: 0,
        esPreVenta: false,
        fechaEntrada: "2021-01-01",
        fechaSalida: "2021-01-05",
        menores0a6: 0,
        menores7a12: 0,
      ),
      Cotizacion(
        adultos: 1,
        categoria: categorias.first,
        plan: planes[1],
        tarifaRealAdulto: 0,
        esPreVenta: false,
        fechaEntrada: "2021-01-01",
        fechaSalida: "2021-01-05",
        menores0a6: 0,
        menores7a12: 0,
      ),
      Cotizacion(
        adultos: 1,
        categoria: categorias[1],
        plan: planes.first,
        tarifaRealAdulto: 0,
        esPreVenta: false,
        fechaEntrada: "2021-01-01",
        fechaSalida: "2021-01-05",
        menores0a6: 0,
        menores7a12: 0,
      ),
      Cotizacion(
        adultos: 1,
        categoria: categorias[1],
        plan: planes[1],
        tarifaRealAdulto: 0,
        esPreVenta: false,
        fechaEntrada: "2021-01-01",
        fechaSalida: "2021-01-05",
        menores0a6: 0,
        menores7a12: 0,
      )
    ],
    comprobante: ComprobanteCotizacion(
        correo: "example@email.com",
        telefono: "01-800-2020",
        nombre: "Example Lorem ipsut"),
    themeDefault: themeDefault,
  );
  return comprobantePDF;
});

final documentQuoteGroupProvider =
    FutureProvider.family<pw.Document, String>((ref, arg) async {
  final detectChanged = ref.watch(changeDocGroupProvider);

  pw.Document comprobantePDF = await GeneradorDocService()
      .generarComprobanteCotizacionGrupal(
          [
        CotizacionGrupal(
          categoria: tipoHabitacion.first,
          fechaEntrada: "2021-01-01",
          fechaSalida: "2021-01-05",
          plan: planes.first,
          tarifaAdulto1_2: 3240,
          tarifaAdulto3: 4500,
          tarifaAdulto4: 5760,
          tarifaMenor: 750,
        ),
        CotizacionGrupal(
          categoria: tipoHabitacion[1],
          fechaEntrada: "2021-01-01",
          fechaSalida: "2021-01-05",
          plan: planes.first,
          tarifaAdulto1_2: 3720,
          tarifaAdulto3: 5220,
          tarifaAdulto4: 6720,
          tarifaMenor: 840,
        ),
        CotizacionGrupal(
          categoria: tipoHabitacion.first,
          fechaEntrada: "2021-01-01",
          fechaSalida: "2021-01-05",
          plan: planes[2],
          tarifaAdulto1_2: 2340,
          tarifaAdulto3: 2970,
          tarifaAdulto4: 3600,
          tarifaMenor: 390,
        ),
        CotizacionGrupal(
          categoria: tipoHabitacion[1],
          fechaEntrada: "2021-01-01",
          fechaSalida: "2021-01-05",
          plan: planes[2],
          tarifaAdulto1_2: 2820,
          tarifaAdulto3: 3690,
          tarifaAdulto4: 4560,
          tarifaMenor: 480,
        ),
      ],
          ComprobanteCotizacion(
              correo: "example@email.com",
              fechaRegistro: "01-01-2021",
              telefono: "01-800-2020",
              nombre: "Example Lorem ipsut"));

  return comprobantePDF;
});

final changeDocIndProvider = StateProvider<int>((ref) {
  return 0;
});

final changeDocGroupProvider = StateProvider<int>((ref) {
  return 0;
});

final themeDefaultIndProvider = StateProvider<bool>((ref) {
  return false;
});
