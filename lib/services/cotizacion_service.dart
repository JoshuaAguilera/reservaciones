import 'package:flutter/material.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/cotizacion_model.dart';

class CotizacionService extends ChangeNotifier {
  List<Cotizacion> cotizaciones = [];

  Future<List<Cotizacion>> getCotizacionesByFolio(String folio) async {
    final database = AppDatabase();

    try {
      List<QuoteData> resp = await database.getQuotesbyFolio(folio);

      for (var element in resp) {
        cotizaciones.add(Cotizacion(
          esGrupo: element.isGroup,
          categoria: element.category,
          plan: element.plan,
          fechaEntrada: element.enterDate,
          fechaSalida: element.outDate,
          adultos: element.adults,
          menores0a6: element.minor0a6,
          menores7a12: element.minor7a12,
          tarifaRealAdulto: element.rateRealAdult,
          tarifaPreventaAdulto: element.ratePresaleAdult,
          tarifaRealMenor: element.rateRealMinor,
          tarifaPreventaMenor: element.ratePresaleMinor,
        ));
      }
       await database.close();
      return cotizaciones;
    } catch (e) {
      print(e);
       await database.close();
      return List.empty();
    }
  }
}
