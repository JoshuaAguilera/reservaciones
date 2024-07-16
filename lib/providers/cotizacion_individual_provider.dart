

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/services/generador_doc_service.dart';
import 'package:pdf/widgets.dart' as pw;

class CotizacionIndividualProvider extends StateNotifier<List<Cotizacion>> {
  CotizacionIndividualProvider() : super([]);

  static final provider =
      StateNotifierProvider<CotizacionIndividualProvider, List<Cotizacion>>(
          (ref) => CotizacionIndividualProvider());

  Cotizacion _current = Cotizacion();
  Cotizacion get current => _current;
  late pw.Document pdfPrinc;

  void addItem(Cotizacion item) {
    _current = item;
    state = [...state, item];
  }

  void remove(int id) {
    state = [...state.where((element) => element.id != id)];
  }

  void clear() {
    state = [];
  }

  Future<pw.Document> generarComprobante(ComprobanteCotizacion comprobante) async {
    pdfPrinc =
        await GeneradorDocService().generarComprobanteCotizacionIndividual(state, comprobante);
    return pdfPrinc;
  }
}