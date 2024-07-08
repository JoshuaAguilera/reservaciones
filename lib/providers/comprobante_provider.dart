import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/argumento_model.dart';
import 'package:generador_formato/models/comprobante_cotizacion_model.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:tuple/tuple.dart';

import '../database/database.dart';
import '../services/comprobante_service.dart';

final comprobanteProvider =
    StateProvider<ComprobanteCotizacion>((ref) => ComprobanteCotizacion());

final comprobanteGeneradoProvider = StateProvider<bool>((ref) => false);

final uniqueFolioProvider =
    StateProvider<String>((ref) => UniqueKey().hashCode.toString());

final comprobanteDetalleProvider =
    StateProvider<ComprobanteCotizacion>((ref) => ComprobanteCotizacion());

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
    FutureProvider.family<List<ReceiptQuoteData>, String>((ref, arg) async {
  final period = ref.watch(periodoProvider);
  final empty = ref.watch(isEmptyProvider);
  final search = ref.watch(searchProvider);
  final pag = ref.watch(paginaProvider);
  final filter = ref.watch(filtroProvider);

  final list = await ComprobanteService().getComprobantesLocales(
    search,
    pag,
    filter,
    empty,
    period,
  );
  return list;
});
