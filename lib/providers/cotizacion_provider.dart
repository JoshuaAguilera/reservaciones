import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/utils/helpers/constants.dart';

import '../database/database.dart';
import '../services/cotizacion_service.dart';

final cotizacionProvider = StateProvider<Cotizacion>((ref) => Cotizacion());

final cotizacionGeneradoProvider = StateProvider<bool>((ref) => false);

final uniqueFolioProvider =
    StateProvider<String>((ref) => UniqueKey().hashCode.toString());

final cotizacionDetalleProvider =
    StateProvider<Cotizacion>((ref) => Cotizacion());

final periodoProvider = StateProvider<String>((ref) => '');

final isEmptyProvider = StateProvider<bool>((ref) => false);

final searchProvider = StateProvider<String>((ref) => '');

final paginaProvider = StateProvider<int>((ref) => 1);

final filtroProvider = StateProvider<String>((ref) => filtros.first);

final changeHistoryProvider = StateProvider<int>((ref) => 0);

final receiptQuoteQueryProvider =
    FutureProvider.family<List<CotizacionData>, String>((ref, arg) async {
  final period = ref.watch(periodoProvider);
  final empty = ref.watch(isEmptyProvider);
  final search = ref.watch(searchProvider);
  final pag = ref.watch(paginaProvider);
  final filter = ref.watch(filtroProvider);

  final detectChanged = ref.watch(changeHistoryProvider);

  final list = await CotizacionService().getCotizacionesLocales(
    search,
    pag,
    filter,
    empty,
    period,
  );
  return list;
});

final saveTariffPolityProvider = StateProvider<Politica?>((ref) => null);
