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

  Future<List<QuoteData>> getCotizacionesIndTimePeriod(
      DateTime initTime, DateTime lastTime) async {
    final dataBase = AppDatabase();
    try {
      List<QuoteData> resp =
          await dataBase.getQuotesIndTimePeriod(initTime, lastTime);

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<QuoteGroupData>> getCotizacionesGroupTimePeriod(
      DateTime initTime, DateTime lastTime) async {
    final dataBase = AppDatabase();
    try {
      List<QuoteGroupData> resp =
          await dataBase.getQuotesGroupTimePeriod(initTime, lastTime);

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<QuoteData>> getCotizacionesIndActuales() async {
    final dataBase = AppDatabase();
    try {
      List<QuoteData> resp = await dataBase.getQuotesIndToday();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<QuoteGroupData>> getCotizacionesGroupActuales() async {
    final dataBase = AppDatabase();
    try {
      List<QuoteGroupData> resp = await dataBase.getQuotesGroupToday();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<QuoteData>> getAllQuoteInd() async {
    final dataBase = AppDatabase();
    try {
      List<QuoteData> resp = await dataBase.getHistoryQuotesInd();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<QuoteGroupData>> getAllQuoteGroup() async {
    final dataBase = AppDatabase();
    try {
      List<QuoteGroupData> resp = await dataBase.getHistoryQuotesGroup();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }
}
