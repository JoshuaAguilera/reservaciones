import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';

import '../database/database.dart';

class ComprobanteService extends ChangeNotifier {
  Future<bool> createComprobante(ComprobanteCotizacion comprobante,
      List<Cotizacion> cotizaciones, String folio) async {
    bool created = false;
    final database = AppDatabase();

    for (var element in cotizaciones) {
      await database.into(database.quote).insert(QuoteCompanion.insert(
            isGroup: false,
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
        ));

    /*
    f

  await database.into(database.todoItems).insert(TodoItemsCompanion.insert(
        title: 'todo: finish drift setup',
        content: 'We can now write queries and define our own tables.',
      ));
  List<TodoItem> allItems = await database.select(database.todoItems).get();

  print('items in database: $allItems');
    */

    return created;
  }

  String generateFolio() {
    String folio = "";
    folio = UniqueKey().hashCode.toString();
    print("new Folio: $folio");
    return folio;
  }
}
