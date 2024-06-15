

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/cotizacion_individual_model.dart';
import 'package:generador_formato/services/generador_doc_service.dart';
import 'package:pdf/widgets.dart' as pw;

class CotizacionIndividualProvider extends StateNotifier<List<CotizacionIndividual>> {
  CotizacionIndividualProvider() : super([]);

  static final provider =
      StateNotifierProvider<CotizacionIndividualProvider, List<CotizacionIndividual>>(
          (ref) => CotizacionIndividualProvider());

  CotizacionIndividual _current = CotizacionIndividual();
  CotizacionIndividual get current => _current;
  late pw.Document pdfPrinc;

  void addItem(CotizacionIndividual item) {
    _current = item;
    state = [...state, item];
  }

  void remove(int id) {
    state = [...state.where((element) => element.id != id)];
  }

  void clear() {
    state = [];
  }

  Future<pw.Document> generarComprobante() async {
    pdfPrinc =
        await GeneradorDocService().generarComprobanteCotizacion(state);
    return pdfPrinc;
  }
}