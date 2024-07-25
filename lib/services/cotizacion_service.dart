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
          esPreVenta: element.isPresale,
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

  Future<List<QuoteData>> getCotizacionesTimePeriod(
      DateTime initTime, DateTime lastTime) async {
    final dataBase = AppDatabase();
    try {
      List<QuoteData> resp =
          await dataBase.getQuotesTimePeriod(initTime, lastTime);

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<QuoteData>> getCotizacionesActuales() async {
    final dataBase = AppDatabase();
    try {
      List<QuoteData> resp = await dataBase.getQuotesToday();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<QuoteData>> getAllQuote() async {
    final dataBase = AppDatabase();
    try {
      List<QuoteData> resp = await dataBase.getHistoryQuotes();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }
}
