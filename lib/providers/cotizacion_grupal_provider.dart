import 'package:generador_formato/models/cotizacion_grupal_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/comprobante_cotizacion_model.dart';
import '../services/generador_doc_service.dart';

class CotizacionGrupalProvider
    extends StateNotifier<List<CotizacionGrupal>> {
  CotizacionGrupalProvider() : super([]);

  static final provider = StateNotifierProvider<CotizacionGrupalProvider,
      List<CotizacionGrupal>>((ref) => CotizacionGrupalProvider());

  CotizacionGrupal _current = CotizacionGrupal();
  CotizacionGrupal get current => _current;
  late pw.Document pdfPrinc;

  void addItem(CotizacionGrupal item) {
    _current = item;
    state = [...state, item];
  }

  void remove(int id) {
    state = [...state.where((element) => element.id != id)];
  }

  void clear() {
    state = [];
  }

  Future<pw.Document> generarComprobante(
      ComprobanteCotizacion comprobante) async {
    // pdfPrinc = await GeneradorDocService()
    //     .generarComprobanteCotizacionIndividual(
    //         cotizaciones: state, comprobante: comprobante);
    return pdfPrinc;
  }
}
