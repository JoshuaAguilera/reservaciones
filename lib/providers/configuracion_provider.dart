import 'package:riverpod/riverpod.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/comprobante_cotizacion_model.dart';
import '../models/cotizacion_model.dart';
import '../services/generador_doc_service.dart';
import '../utils/helpers/constants.dart';

final documentQuoteIndProvider =
    FutureProvider.family<pw.Document, String>((ref, arg) async {
  pw.Document comprobantePDF = await GeneradorDocService()
      .generarComprobanteCotizacion(
          [
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
          ComprobanteCotizacion(
              correo: "example@email.com",
              telefono: "01-800-2020",
              nombre: "Example Lorem ipsut"));
  return comprobantePDF;
});
