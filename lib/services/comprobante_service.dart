import 'dart:isolate';

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
            dateRegister: DateTime.now().toIso8601String(),
            rateDay:
                Utility.calculateTarifaDiaria(cotizacion: cotizaciones.first),
            total: Utility.calculateTarifaTotal(cotizaciones),
          ));

      database.close();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<ReceiptQuoteData>> getComprobantesLocales() async {
    final database = AppDatabase();
    try {
      List<ReceiptQuoteData> comprobantes =
          await database.select(database.receiptQuote).get();
      database.close();
      return comprobantes;
    } catch (e) {
      print(e);
      return List.empty();
    }
  }

  Future<bool> eliminarComprobante(String folio) async {
    final database = AppDatabase();
    try {
      await database.deleteReceiptQuoteByFolio(folio).toString();
      database.close();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
