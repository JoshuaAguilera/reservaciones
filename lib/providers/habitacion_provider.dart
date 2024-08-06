import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/services/generador_doc_service.dart';
import 'package:pdf/widgets.dart' as pw;

class HabitacionProvider extends StateNotifier<List<Habitacion>> {
  HabitacionProvider() : super([]);

  static final provider =
      StateNotifierProvider<HabitacionProvider, List<Habitacion>>(
          (ref) => HabitacionProvider());

  Habitacion _current = Habitacion();
  Habitacion get current => _current;
  late pw.Document pdfPrinc;

  void addItem(Habitacion item) {
    _current = item;
    state = [...state, item];
  }

  void remove(int id) {
    state = [...state.where((element) => element.id != id)];
  }

  void clear() {
    state = [];
  }

  Future<pw.Document> generarComprobante(Cotizacion cotizacion) async {
    pdfPrinc = await GeneradorDocService()
        .generarComprobanteCotizacionIndividual(
            habitaciones: state, cotizacion: cotizacion);
    return pdfPrinc;
  }
}
