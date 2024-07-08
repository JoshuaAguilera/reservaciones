import 'package:flutter/cupertino.dart';
import 'package:generador_formato/models/prefijo_telefonico_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';

import '../database/database.dart';

class ComprobanteService extends ChangeNotifier {
  Future<bool> createComprobante(
      ComprobanteCotizacion comprobante,
      List<Cotizacion> cotizaciones,
      String folio,
      PrefijoTelefonico prefijoInit) async {
    final database = AppDatabase();

    try {
      database.transaction(
        () async {
          for (var element in cotizaciones) {
            await database.into(database.quote).insert(QuoteCompanion.insert(
                  isGroup: false,
                  isPresale: element.esPreVenta!,
                  folio: folio,
                  category: element.categoria ?? '',
                  plan: element.plan ?? '',
                  registerDate: DateTime.now(),
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
                numPhone: prefijoInit.prefijo + comprobante.telefono!,
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
          comprobantes = await database
              .getReceiptQuotesTimePeriod(initTime, lastTime, search: search);
        } else {
          switch (filtro) {
            case "Todos":
              if (search.isNotEmpty) {
                comprobantes = await database.getReceiptQuotesSearch(search);
              } else {
                comprobantes =
                    await database.select(database.receiptQuote).get();
              }
              break;
            case 'Hace un dia':
              comprobantes =
                  await database.getReceiptQuotesLastDay(search: search);
              break;
            case 'Hace una semana':
              comprobantes =
                  await database.getReceiptQuotesLastWeek(search: search);
              break;
            case 'Hace un mes':
              comprobantes =
                  await database.getReceiptQuotesLastMont(search: search);
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

  Future<List<ReceiptQuoteData>> getComprobantesRecientes() async {
    final dataBase = AppDatabase();
    try {
      List<ReceiptQuoteData> resp = await dataBase.getReceiptQuotesRecent();

      await dataBase.close();
      return resp;
    } catch (e) {
      return List.empty();
    }
  }
}
