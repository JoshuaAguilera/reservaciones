import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/database.dart';
import '../../models/cotizacion_model.dart';
import '../../models/periodo_model.dart';
import '../../models/politica_tarifario_model.dart';
import '../../res/helpers/constants.dart';
import '../services/cotizacion_service.dart';

final cotizacionProvider = StateProvider<Cotizacion>((ref) => Cotizacion());

final uniqueFolioProvider =
    StateProvider<String>((ref) => UniqueKey().hashCode.toString());

final cotizacionDetalleProvider =
    StateProvider<Cotizacion>((ref) => Cotizacion());

final periodoProvider = StateProvider<Periodo?>((ref) => null);

final isEmptyProvider = StateProvider<bool>((ref) => false);

final showFilterProvider = StateProvider<List<bool>>(
    (ref) => [true, false, false, false, false, false]);

final searchProvider = StateProvider<String>((ref) => '');

final paginaProvider = StateProvider<int>((ref) => 1);

final filtroProvider = StateProvider<String>((ref) => filtros.first);

final changeHistoryProvider = StateProvider<int>((ref) => 0);

final receiptQuoteQueryProvider =
    FutureProvider.family<List<Cotizacion>, String>((ref, arg) async {
  final period = ref.watch(periodoProvider);
  final empty = ref.watch(isEmptyProvider);
  final search = ref.watch(searchProvider);
  final pag = ref.watch(paginaProvider);
  final filter = ref.watch(filtroProvider);
  final showFilter = ref.watch(showFilterProvider);

  final detectChanged = ref.watch(changeHistoryProvider);

  final list = await CotizacionService().getList(
    search: empty ? '' : search,
    lapso: filter,
    pagina: pag,
    initDate: period?.fechaInicial,
    lastDate: period?.fechaFinal,
    showFilter: showFilter,
  );

  return list;
});

final saveTariffPolityProvider = StateProvider<PoliticaTarifario?>((ref) {
  return null;
});
