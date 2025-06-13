import 'package:riverpod/riverpod.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/cotizacion_model.dart';
import '../models/habitacion_model.dart';
import '../services/generador_doc_service.dart';
import '../res/helpers/constants.dart';

final documentQuoteIndProvider =
    FutureProvider.family<pw.Document, String>((ref, arg) async {
  final detectChanged = ref.watch(changeDocIndProvider);
  final themeDefault = ref.watch(themeDefaultIndProvider);

  pw.Document comprobantePDF =
      await GeneradorDocService().generarComprobanteCotizacionIndividual(
    habitaciones: [
      Habitacion(
        categoria: categorias.first,
        fechaCheckIn: "2021-01-01",
        fechaCheckOut: "2021-01-05",
      ),
      Habitacion(
        categoria: categorias.first,
        fechaCheckIn: "2021-01-01",
        fechaCheckOut: "2021-01-05",
      ),
      Habitacion(
        categoria: categorias[1],
        fechaCheckIn: "2021-01-01",
        fechaCheckOut: "2021-01-05",
      ),
      Habitacion(
        categoria: categorias[1],
        fechaCheckIn: "2021-01-01",
        fechaCheckOut: "2021-01-05",
      )
    ],
    cotizacion: Cotizacion(
        correoElectronico: "example@email.com",
        numeroTelefonico: "01-800-2020",
        nombreHuesped: "Example Lorem ipsut"),
    themeDefault: themeDefault,
  );
  return comprobantePDF;
});

final documentQuoteGroupProvider =
    FutureProvider.family<pw.Document, String>((ref, arg) async {
  final detectChanged = ref.watch(changeDocGroupProvider);

  pw.Document comprobantePDF =
      await GeneradorDocService().generarComprobanteCotizacionGrupal(
    habitaciones: [],
    cotizacion: Cotizacion(
        correoElectronico: "example@email.com",
        fecha: "01-01-2021",
        numeroTelefonico: "01-800-2020",
        nombreHuesped: "Example Lorem ipsut"),
  );

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
