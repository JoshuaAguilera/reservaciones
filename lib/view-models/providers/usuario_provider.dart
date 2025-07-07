import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:tuple/tuple.dart';

import '../../models/estatus_snackbar_model.dart';
import '../../models/imagen_model.dart';
import '../../models/usuario_model.dart';
import '../../utils/shared_preferences/preferences.dart';
import '../services/usuario_service.dart';
import 'ui_provider.dart';

final getUserProvider = FutureProvider<Usuario?>((ref) async {
  final userId = Preferences.userIdInt;
  if (userId == 0) return null;
  final user = await UsuarioService().getByID(userId);
  ref.watch(userProvider.notifier).state = user;
  ref.watch(imagePerfilProvider.notifier).state = user?.imagen;
  return user;
});

final userProvider = StateProvider<Usuario?>((ref) => null);
final imagePerfilProvider = StateProvider<Imagen?>((ref) => Imagen());
final changeUsersProvider = StateProvider<int>((ref) => 0);

// User Module Providers
final msgSuccessProvider = StateProvider<String?>((ref) => null);
final usuarioSearchProvider = StateProvider<String?>((ref) => null);
final passwordContProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

class UsuariosNotifier extends PagedNotifier<int, Usuario> {
  final Ref ref;

  UsuariosNotifier(this.ref, Tuple4<String, String, String, String> mix)
      : super(
          load: (page, limit) {
            return UsuarioService().getList(
              username: mix.item1,
              orderBy: mix.item2,
              estatus: mix.item4,
              limit: limit,
              page: page,
            );
          },
          nextPageKeyBuilder: NextPageKeyBuilderDefault.mysqlPagination,
        );

  void selectAll(bool selectAll) {
    final nuevaLista = state.records?.map((usuario) {
      usuario.select = selectAll;
      return usuario;
    }).toList();

    state = state.copyWith(records: nuevaLista);
  }

  bool withSelections() {
    bool res = state.records?.any((element) => element.select) ?? false;

    if (!res) {
      ref.read(snackbarServiceProvider).showCustomSnackBar(
            message: "Sin elementos selecionados",
            duration: Duration(seconds: 3),
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

  Future<bool> deleteUser({bool onlyRemove = true}) async {
    for (var element in state.records ?? List<Usuario>.empty()) {
      if (element.select) {
        final status = onlyRemove
            ? await UsuarioService().setStatus(element, "declinado")
            : await UsuarioService().delete(element);

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
          message:
              "Usuarios ${onlyRemove ? "declinados" : "eliminados"} correctamente",
          type: TypeSnackbar.success,
          withIcon: true,
          maxLines: 2,
        );
    return false;
  }
}

final usuariosProvider = StateNotifierProvider.family<
    UsuariosNotifier,
    PagedState<int, Usuario>,
    Tuple4<String, String, String, String>>((ref, mix) {
  return UsuariosNotifier(ref, mix);
});

final usuariosDeclinadosProvider = StateNotifierProvider.family<
    UsuariosNotifier,
    PagedState<int, Usuario>,
    Tuple4<String, String, String, String>>((ref, mix) {
  return UsuariosNotifier(ref, mix);
});

final usuarioProvider = StateProvider<Usuario?>((ref) => null);

final saveUserProvider = FutureProvider<Tuple2<bool, Usuario?>>(
  (ref) async {
    final user = ref.watch(usuarioProvider);
    final msg = ref.read(msgSuccessProvider);

    if (user != null) {
      final response = await UsuarioService().saveData(user: user);

      if (response.item3) {
        ref.read(navigationServiceProvider).navigateToLoginAndReplace();
        return const Tuple2(true, null);
      }

      if (response.item1 != null) {
        ref.read(snackbarServiceProvider).showCustomSnackBar(
              error: response.item1,
              type: TypeSnackbar.danger,
              withIcon: true,
            );
        return const Tuple2(true, null);
      }

      if (response.item2 != null) {
        ref.read(snackbarServiceProvider).showCustomSnackBar(
              message: msg ??
                  "Usuario ${user.id != null ? "actualizado" : "creado"} correctamente",
              duration: const Duration(seconds: 3),
              type: TypeSnackbar.success,
              withIcon: true,
              maxLines: 2,
            );
      }

      ref.watch(msgSuccessProvider.notifier).update((state) => null);
      return Tuple2(false, response.item2);
    }
    return const Tuple2(false, null);
  },
);

final setStatusUserProvider = FutureProvider<bool>(
  (ref) async {
    final user = ref.watch(usuarioProvider);

    if (user != null) {
      final response = await UsuarioService().setStatus(user, "registrado");
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
      ref.read(snackbarServiceProvider).showCustomSnackBar(
            message: "Usuarios declinados correctamente",
            duration: const Duration(seconds: 3),
            type: TypeSnackbar.success,
            withIcon: true,
          );

      return false;
    } else {
      return false;
    }
  },
);

final deleteUserProvider = FutureProvider<bool>(
  (ref) async {
    final user = ref.watch(usuarioProvider);

    if (user != null) {
      final response = await UsuarioService().delete(user);

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
            message: "Usuario eliminado correctamente",
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

final keyUserListProvider = StateProvider<String>((ref) {
  return UniqueKey().hashCode.toString();
});

final keyReduceListProvider = StateProvider<String>((ref) {
  return UniqueKey().hashCode.toString();
});

final updateViewUserListProvider = StateProvider<String>((ref) {
  return UniqueKey().hashCode.toString();
});

final isEmptyUserProvider = StateProvider<bool>((ref) => false);

final foundImageFileProvider = StateProvider<bool>((ref) => false);

final searchUserProvider = StateProvider<String>((ref) => '');

// final userQueryProvider =
//     FutureProvider.family<List<Usuario>, String>((ref, arg) async {
//   // final period = ref.watch(periodoProvider);
//   final empty = ref.watch(isEmptyUserProvider);
//   final search = ref.watch(searchUserProvider);
//   // final pag = ref.watch(paginaProvider);
//   // final filter = ref.watch(filtroProvider);

//   final detectChanged = ref.watch(changeUsersProvider);

//   final list = await AuthService().getUsers(search, empty);
//   return list;
// });
