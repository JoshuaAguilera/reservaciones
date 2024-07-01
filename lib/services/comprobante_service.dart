import 'package:flutter/cupertino.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';

import '../database/database.dart';

class ComprobanteService extends ChangeNotifier {
  Future<bool> createComprobante(ComprobanteCotizacion comprobante,
      List<Cotizacion> cotizaciones, String folio) async {
    final database = AppDatabase();

    try {
      database.transaction(
        () async {
          for (var element in cotizaciones) {
            await database.into(database.quote).insert(QuoteCompanion.insert(
                  isGroup: false,
                  folio: folio,
                  category: element.categoria ?? '',
                  plan: element.plan ?? '',
                  enterDate: element.fechaEntrada ?? '',
                  outDate: element.fechaSalida ?? '',
                  adults: element.adultos!,
                  minor0a6: element.menores0a6!,
                  minor7a12: element.menores7a12!,
                  rateRealAdult: element.tarifaRealAdulto ?? 0,
                  ratePresaleAdult: element.tarifaPreventaAdulto ?? 0,
                  rateRealMinor: element.tarifaRealMenor ?? 0,
                  ratePresaleMinor: element.tarifaPreventaMenor ?? 0,
                ));
          }

          await database
              .into(database.receiptQuote)
              .insert(ReceiptQuoteCompanion.insert(
                folioQuotes: folio,
                mail: comprobante.correo!,
                nameCustomer: comprobante.nombre!,
                numPhone: comprobante.telefono!,
                userId: 1,
                dateRegister: DateTime.now(),
                rateDay: Utility.calculateTarifaDiaria(
                    cotizacion: cotizaciones.first),
                total: Utility.calculateTarifaTotal(cotizaciones),
              ));
        },
      );
      await database.close();
      return true;
    } catch (e) {
      print(e);
      await database.close();
      return false;
    }
  }

  Future<List<ReceiptQuoteData>> getComprobantesLocales(
      String search, int pag, String filtro, bool empty, String periodo) async {
    final database = AppDatabase();
    try {
      List<ReceiptQuoteData> comprobantes = [];
      if (empty) {
        comprobantes = await database.select(database.receiptQuote).get();
      } else {
        if (periodo.isNotEmpty) {
          print(periodo);
          DateTime initTime = DateTime.parse(periodo.substring(0, 10));
          DateTime lastTime = DateTime.parse(periodo.substring(10, 20));
          comprobantes =
              await database.getReceiptQuotesTimePeriod(initTime, lastTime);
        } else if (search.isNotEmpty) {
          comprobantes = await database.getReceiptQuotesSearch(search);
        } else {
          switch (filtro) {
            case "Todos":
              comprobantes = await database.select(database.receiptQuote).get();
              break;
            case 'Hace un dia':
              comprobantes = await database.getReceiptQuotesLastDay();
              break;
            case 'Hace una semana':
              comprobantes = await database.getReceiptQuotesLastWeek();
              break;
            case 'Hace un mes':
              comprobantes = await database.getReceiptQuotesLastMont();
              break;
            default:
          }
        }
      }

      await database.close();
      return comprobantes;
    } catch (e) {
      print(e);
      await database.close();

      return List.empty();
    }
  }

  Future<bool> eliminarComprobante(String folio) async {
    final database = AppDatabase();
    try {
      await database.deleteReceiptQuoteByFolio(folio).toString();
      await database.deleteQuotesByFolio(folio).toString();

      await database.close();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
