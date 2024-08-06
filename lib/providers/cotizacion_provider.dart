import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/cotizacion_model.dart';
import 'package:generador_formato/utils/helpers/constants.dart';

import '../database/database.dart';
import '../services/cotizacion_service.dart';

final cotizacionProvider =
    StateProvider<Cotizacion>((ref) => Cotizacion());

final cotizacionGeneradoProvider = StateProvider<bool>((ref) => false);

final uniqueFolioProvider =
    StateProvider<String>((ref) => UniqueKey().hashCode.toString());

final cotizacionDetalleProvider =
    StateProvider<Cotizacion>((ref) => Cotizacion());

final periodoProvider = StateProvider<String>((ref) {
  return '';
});

final isEmptyProvider = StateProvider<bool>((ref) {
  return false;
});

final searchProvider = StateProvider<String>((ref) {
  return '';
});

final paginaProvider = StateProvider<int>((ref) {
  return 1;
});

final filtroProvider = StateProvider<String>((ref) {
  return filtros.first;
});

final receiptQuoteQueryProvider =
    FutureProvider.family<List<CotizacionData>, String>((ref, arg) async {
  final period = ref.watch(periodoProvider);
  final empty = ref.watch(isEmptyProvider);
  final search = ref.watch(searchProvider);
  final pag = ref.watch(paginaProvider);
  final filter = ref.watch(filtroProvider);

  final list = await CotizacionService().getCotizacionesLocales(
    search,
    pag,
    filter,
    empty,
    period,
  );
  return list;
});
