import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:tuple/tuple.dart';

import '../../models/categoria_model.dart';
import '../../models/estatus_snackbar_model.dart';
import '../../models/list_helper_model.dart';
import '../services/categoria_service.dart';
import 'ui_provider.dart';

final filterCategoryProvider = StateProvider<Filter>((ref) {
  return Filter(
    layout: Layout.checkList,
    orderBy: OrderBy.antiguo,
  );
});

final searchCategoryProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final selectCategoryProvider = StateProvider<bool>((ref) => false);
final selectAllCategoryProvider = StateProvider<bool>((ref) => false);

final categoriaSearchProvider = StateProvider<String>((ref) => "");

class CategoriasNotifier extends PagedNotifier<int, Categoria> {
  final Ref ref;

  CategoriasNotifier(this.ref, Tuple3<String, String, String> mix)
      : super(
          load: (page, limit) {
            return CategoriaService().getList(
              page: page,
              limit: limit,
              nombre: mix.item1,
              orderBy: mix.item2,
            );
          },
          nextPageKeyBuilder: NextPageKeyBuilderDefault.mysqlPagination,
        );

  void selectAll(bool selectAll) {
    final nuevaLista = state.records?.map((categoria) {
      categoria.isSelect = selectAll;
      return categoria;
    }).toList();

    state = state.copyWith(records: nuevaLista);
  }

  bool withSelections() {
    bool res = state.records?.any((element) => element.isSelect) ?? false;

    if (!res) {
      ref.read(snackbarServiceProvider).showCustomSnackBar(
            message: "Sin elementos selecionados",
            duration: const Duration(seconds: 3),
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

  Future<bool> delete() async {
    for (var element in state.records ?? List<Categoria>.empty()) {
      if (element.isSelect) {
        final status = await CategoriaService().delete(element);

        if (status.item1 != null) {
          ref.read(snackbarServiceProvider).showCustomSnackBar(
                error: status.item1,
                type: TypeSnackbar.danger,
                withIcon: true,
              );
          return true;
        }
      }
    }

    selectAll(false);
    ref.read(snackbarServiceProvider).showCustomSnackBar(
          message: "Categorias eliminados correctamente",
          type: TypeSnackbar.success,
          withIcon: true,
          maxLines: 2,
        );
    return false;
  }
}

final categoriasProvider = StateNotifierProvider.family<CategoriasNotifier,
    PagedState<int, Categoria>, Tuple3<String, String, String>>((ref, mix) {
  return CategoriasNotifier(ref, mix);
});

final categoriasReqProvider =
    FutureProvider.family<List<Categoria>, String>((ref, arg) async {
  var nombre = arg;
  final list = await CategoriaService().getList(nombre: nombre, limit: 100);
  return list;
});

final categoriaListProvider =
    FutureProvider.family<List<Categoria>, String>((ref, arg) async {
  final list = await CategoriaService().getList();
  return list;
});

final categoriaProvider = StateProvider<Categoria?>((ref) => null);

final saveCategoryProvider = FutureProvider<bool>(
  (ref) async {
    final resource = ref.watch(categoriaProvider);

    if (resource != null) {
      final response = await CategoriaService().saveData(resource);

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
                  "Categoria ${resource.id != null ? "actualizado" : "creado"} correctamente",
              type: TypeSnackbar.success,
              withIcon: true,
            );
      }

      return false;
    }
    return false;
  },
);

final deleteCategoryProvider = FutureProvider<bool>(
  (ref) async {
    final resource = ref.watch(categoriaProvider);

    if (resource != null) {
      final response = await CategoriaService().delete(resource);
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
            message: "Recurso eliminado correctamente",
            duration: Duration(seconds: 3),
            type: TypeSnackbar.success,
            withIcon: true,
          );

      return false;
    } else {
      return false;
    }
  },
);

final keyCategoryListProvider = StateProvider<String>((ref) {
  return UniqueKey().hashCode.toString();
});

final updateViewCategoryListProvider = StateProvider<String>((ref) {
  return UniqueKey().hashCode.toString();
});
