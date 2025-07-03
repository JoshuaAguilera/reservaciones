import 'package:riverpod/riverpod.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../models/cliente_model.dart';
import '../../models/cotizacion_model.dart';
import '../../models/habitacion_model.dart';
import '../services/generador_doc_service.dart';
import '../../res/helpers/constants.dart';

final documentQuoteIndProvider =
    FutureProvider.family<pw.Document, String>((ref, arg) async {
  final detectChanged = ref.watch(changeDocIndProvider);
  final themeDefault = ref.watch(themeDefaultIndProvider);

  pw.Document comprobantePDF =
      await GeneradorDocService().generarCompInd(
    habitaciones: [
      // Habitacion(
      //   categoria: categorias.first,
      //   checkIn: "2021-01-01",
      //   checkOut: "2021-01-05",
      // ),
      // Habitacion(
      //   categoria: categorias.first,
      //   checkIn: "2021-01-01",
      //   checkOut: "2021-01-05",
      // ),
      // Habitacion(
      //   categoria: categorias[1],
      //   checkIn: "2021-01-01",
      //   checkOut: "2021-01-05",
      // ),
      // Habitacion(
      //   categoria: categorias[1],
      //   checkIn: "2021-01-01",
      //   checkOut: "2021-01-05",
      // )
    ],
    cotizacion: Cotizacion(
      cliente: Cliente(
        correoElectronico: "example@email.com",
        numeroTelefonico: "01-800-2020",
        nombres: "Example Lorem ipsut",
      ),
    ),
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
        createdAt: DateTime.now(),
        cliente: Cliente(
          correoElectronico: "example@email.com",
          numeroTelefonico: "01-800-2020",
          nombres: "Example Lorem ipsut",
        )),
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
