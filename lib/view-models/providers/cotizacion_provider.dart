import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:tuple/tuple.dart';

import '../../models/cotizacion_model.dart';
import '../../models/estatus_snackbar_model.dart';
import '../../models/filter_model.dart';
import '../../models/periodo_model.dart';
import '../../models/politica_tarifario_model.dart';
import '../../models/usuario_model.dart';
import '../../res/helpers/constants.dart';
import '../services/cotizacion_service.dart';
import 'dashboard_provider.dart';
import 'ui_provider.dart';
import 'usuario_provider.dart';

// Proveedores de consulta de cotizacion por ID
final cotizacionByIdProvider =
    FutureProvider.family<Cotizacion?, Tuple2<String?, int?>?>(
        (ref, arg) async {
  if (arg == null) return null;
  final cotizacion = await CotizacionService().getByID(arg);
  return cotizacion;
});

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

final filterQuoteProvider = StateProvider<Filter>((ref) {
  return Filter(
    layout: Layout.checkList,
    orderBy: OrderBy.antiguo,
    status: "",
  );
});

final searchQuoteProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final selectQuoteProvider = StateProvider<bool>((ref) => false);
final selectAllQuoteProvider = StateProvider<bool>((ref) => false);
final quoteSearchProvider = StateProvider<String>((ref) => "");

class CotizacionesNotifier extends PagedNotifier<int, Cotizacion> {
  final Ref ref;

  CotizacionesNotifier(this.ref,
      Tuple6<String, String, Usuario?, List<bool>, Periodo?, String> mix)
      : super(
          load: (page, limit) {
            return CotizacionService().getList(
              pagina: page,
              limit: limit,
              search: mix.item1,
              ordenBy: mix.item2,
              creadorPor: mix.item3,
              showFilter: mix.item4,
              initDate: mix.item5?.fechaInicial,
              lastDate: mix.item5?.fechaFinal,
            );
          },
          nextPageKeyBuilder: NextPageKeyBuilderDefault.mysqlPagination,
        );

  void selectAll(bool selectAll) {
    final nuevaLista = state.records?.map((rol) {
      rol.select = selectAll;
      return rol;
    }).toList();

    state = state.copyWith(records: nuevaLista);
  }

  bool withSelections() {
    bool res = state.records?.any((element) => element.select) ?? false;

    if (!res) {
      ref.read(snackbarServiceProvider).showCustomSnackBar(
            message: "Sin elementos selecionados",
            type: TypeSnackbar.alert,
            withIcon: true,
          );
    }
    return res;
  }

  bool isNotEmpty() {
    bool status = state.records?.isNotEmpty ?? false;
    if (!status) {
      ref.read(snackbarServiceProvider).showCustomSnackBar(
            message: "Sin elementos seleccionables",
            duration: const Duration(seconds: 3),
            type: TypeSnackbar.alert,
            withIcon: true,
          );
    }
    return status;
  }

  Future<bool> deleteSelection() async {
    for (var element in state.records ?? List<Cotizacion>.empty()) {
      if (element.select) {
        final response = await CotizacionService().delete(element);

        if (response.item1 != null) {
          ref.read(snackbarServiceProvider).showCustomSnackBar(
                error: response.item1,
                type: TypeSnackbar.danger,
                withIcon: true,
              );
          return true;
        }
      }
    }

    selectAll(false);
    ref.read(snackbarServiceProvider).showCustomSnackBar(
          message: "Roles eliminados correctamente",
          type: TypeSnackbar.success,
          withIcon: true,
          maxLines: 2,
        );
    return false;
  }
}

final cotizacionesProvider = StateNotifierProvider.family<CotizacionesNotifier,
    PagedState<int, Cotizacion>, String>((ref, mix) {
  final period = ref.watch(periodoProvider);
  final search = ref.watch(searchProvider);
  final orderBy = ref.watch(filtroProvider);
  final showFilter = ref.watch(showFilterProvider);
  final keyList = ref.watch(keyQuoteListProvider);
  final user = ref.watch(userProvider);
  final filter = ref.watch(filtroDashboardProvider);

  return CotizacionesNotifier(
    ref,
    Tuple6(
      search,
      orderBy,
      filter == "Equipo" ? null : user,
      showFilter,
      period,
      keyList,
    ),
  );
});

final cotizacionesReqProvider =
    FutureProvider.family<List<Cotizacion>, String>((ref, arg) async {
  var nombre = arg;
  final list = await CotizacionService().getList(search: nombre);
  return list;
});

final cotizacionProvider = StateProvider<Cotizacion?>((ref) => null);

final saveQuoteProvider = FutureProvider<bool>(
  (ref) async {
    final cotizacion = ref.watch(cotizacionProvider);

    if (cotizacion != null) {
      final response = await CotizacionService().saveData(cotizacion);
      if (response.item3) {
        ref.read(navigationServiceProvider).navigateToLoginAndReplace();
        return true;
      }

      if (response.item1 != null) {
        ref.read(snackbarServiceProvider).showCustomSnackBar(
              error: response.item1,
              type: TypeSnackbar.danger,
              withIcon: true,
            );
        return true;
      }

      if (response.item2 != null) {
        ref.read(snackbarServiceProvider).showCustomSnackBar(
              message:
                  "Cotización ${cotizacion.id != null ? "actualizada" : "creada"} correctamente",
              type: TypeSnackbar.success,
              withIcon: true,
            );
      }

      return false;
    }
    return false;
  },
);

final deleterCotizacionProvider = FutureProvider<bool>(
  (ref) async {
    final cotizacion = ref.watch(cotizacionProvider);

    if (cotizacion != null) {
      final response = await CotizacionService().delete(cotizacion);
      if (response.item2) {
        ref.read(navigationServiceProvider).navigateToLoginAndReplace();
        return true;
      }

      if (response.item1 != null) {
        ref.read(snackbarServiceProvider).showCustomSnackBar(
              error: response.item1,
              type: TypeSnackbar.danger,
              withIcon: true,
            );
        return true;
      }
      ref.read(snackbarServiceProvider).showCustomSnackBar(
            message: "Cotización eliminada correctamente",
            type: TypeSnackbar.success,
            withIcon: true,
          );

      return false;
    } else {
      return false;
    }
  },
);

final keyQuoteListProvider = StateProvider<String>((ref) {
  return UniqueKey().hashCode.toString();
});

final updateViewQuoteListProvider = StateProvider<String>((ref) {
  return UniqueKey().hashCode.toString();
});
