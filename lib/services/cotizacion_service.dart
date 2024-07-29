import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/cotizacion_grupal_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';

import 'base_service.dart';

class CotizacionService extends BaseService {
  List<Cotizacion> cotizacionesInd = [];
  List<CotizacionGrupal> cotizacionesGrup = [];

  Future<List<Cotizacion>> getCotizacionesIndByFolio(String folio) async {
    final database = AppDatabase();

    try {
      List<QuoteData> resp = await database.getQuotesIndbyFolio(folio);

      for (var element in resp) {
        cotizacionesInd.add(Cotizacion(
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
      return cotizacionesInd;
    } catch (e) {
      print(e);
      await database.close();
      return List.empty();
    }
  }

  Future<List<CotizacionGrupal>> getCotizacionesGrupByFolio(
      String folio) async {
    final database = AppDatabase();

    try {
      List<QuoteGroupData> resp = await database.getQuotesGroupbyFolio(folio);

      for (var element in resp) {
        cotizacionesGrup.add(CotizacionGrupal(
          categoria: element.category,
          plan: element.plan,
          fechaEntrada: element.enterDate,
          fechaSalida: element.outDate,
          esPreVenta: element.isPresale,
          tarifaAdulto1_2: element.rateAdult1_2,
          tarifaAdulto3: element.rateAdult3,
          tarifaAdulto4: element.rateAdult4,
          tarifaMenor: element.rateMinor,
        ));
      }
      await database.close();
      return cotizacionesGrup;
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
