import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:tuple/tuple.dart';

import '../../models/estatus_snackbar_model.dart';
import '../../models/rol_model.dart';
import '../services/rol_service.dart';
import 'ui_provider.dart';
import 'usuario_provider.dart';

final permissionsProvider =
    StateProvider.autoDispose.family<bool, Tuple2<List<String>, List<String>>>(
  (ref, arg) {
    bool found = false;
    final userData = ref.watch(userProvider);

    for (var permission in arg.item1) {
      found = userData?.rol?.permisos
              ?.any((element) => element.resource == permission) ??
          false;
      if (found && arg.item2.isNotEmpty) {
        bool foundAction = false;

        for (var action in arg.item2) {
          foundAction = userData?.rol?.permisos?.any((element) =>
                  element.action == action && element.resource == permission) ??
              false;
          if (foundAction) {
            found = true;
            break;
          } else {
            found = false;
          }
        }
      }
      if (found) break;
    }

    return found;
  },
);

final rolSearchProvider = StateProvider<String>((ref) => "");

class RolesNotifier extends PagedNotifier<int, Rol> {
  final Ref ref;

  RolesNotifier(this.ref, Tuple3<String, String, String> mix)
      : super(
          load: (page, limit) {
            return RolService().getList(
              page: page,
              limit: limit,
              nombre: mix.item1,
              orderBy: mix.item2,
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
            type: TypeSnackbar.alert,
            withIcon: true,
          );
    }
    return status;
  }

  Future<bool> deleteSelection() async {
    for (var element in state.records ?? List<Rol>.empty()) {
      if (element.select) {
        final response = await RolService().delete(element);

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

final rolesProvider = StateNotifierProvider.family<RolesNotifier,
    PagedState<int, Rol>, Tuple3<String, String, String>>((ref, mix) {
  return RolesNotifier(ref, mix);
});

final rolesReqProvider =
    FutureProvider.family<List<Rol>, String>((ref, arg) async {
  var nombre = arg;
  final list = await RolService().getList(nombre: nombre);
  return list;
});

final rolProvider = StateProvider<Rol?>((ref) => null);

final saveRoleProvider = FutureProvider<bool>(
  (ref) async {
    final rol = ref.watch(rolProvider);

    if (rol != null) {
      final response = await RolService().saveData(rol);
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
                  "Rol ${rol.id != null ? "actualizado" : "creado"} correctamente",
              type: TypeSnackbar.success,
              withIcon: true,
            );
      }

      return false;
    }
    return false;
  },
);

final deleterRolProvider = FutureProvider<bool>(
  (ref) async {
    final rol = ref.watch(rolProvider);

    if (rol != null) {
      final response = await RolService().delete(rol);
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
            message: "Rol eliminado correctamente",
            type: TypeSnackbar.success,
            withIcon: true,
          );

      return false;
    } else {
      return false;
    }
  },
);

final keyRoleListProvider = StateProvider<String>((ref) {
  return UniqueKey().hashCode.toString();
});

final updateViewRoleListProvider = StateProvider<String>((ref) {
  return UniqueKey().hashCode.toString();
});
