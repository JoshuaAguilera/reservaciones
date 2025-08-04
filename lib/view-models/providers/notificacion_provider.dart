import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:tuple/tuple.dart';

import '../../models/estatus_snackbar_model.dart';
import '../../models/list_helper_model.dart';
import '../../models/notificacion_model.dart';
import '../services/notificacion_service.dart';
import 'ui_provider.dart';
import 'usuario_provider.dart';

final getNotifProvider =
    FutureProvider.family<List<Notificacion>, String>((ref, arg) async {
  final user = ref.watch(userProvider);
  final list = await NotificacionService().getList(usuario: user);
  return list;
});

final filterNotProvider = StateProvider<Filter>((ref) {
  return Filter(orderBy: OrderBy.recientes, status: "");
});

final searchNotProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final selectNotificationsProvider = StateProvider<bool>((ref) => false);
final selectAllNotificationsProvider = StateProvider<bool>((ref) => false);

final notificationSearchProvider = StateProvider<String>((ref) => "");

class NotificacionesNotifier extends PagedNotifier<int, Notificacion> {
  final Ref ref;

  NotificacionesNotifier(this.ref, Tuple4<String, String, String, String> mix)
      : super(
          load: (page, limit) {
            final user = ref.watch(userProvider);

            final test = [
              Notificacion(
                idInt: 1,
                tipo: NotificationType.info,
                documento: "cotizacion",
                estatus: "Enviado",
                title: "Nueva cotización recibida",
                message:
                    "Revisa la cotización enviada al cliente por el usuario ${user?.username ?? 'desconocido'}",
                usuario: user,
                createdAt: DateTime.now(),
              ),
              Notificacion(
                idInt: 1,
                tipo: NotificationType.alert,
                documento: "cotizacion",
                estatus: "Enviado",
                title: "Cotizaciones a punto de vencer",
                message: "Revisa las cotizaciones que están por vencer",
                usuario: user,
                createdAt: DateTime.now(),
              ),
              Notificacion(
                idInt: 1,
                tipo: NotificationType.danger,
                documento: "cotizacion",
                estatus: "Leido",
                title: "Cotizacion cancelada",
                message:
                    "La cotización ha sido cancelada por el cliente, revisa el motivo",
                usuario: user,
                createdAt: DateTime.now(),
              ),
            ];

            return Future.value(test);

            // return NotificacionService().getList(
            //   page: page,
            //   limit: limit,
            //   tipo: mix.item1,
            //   orderBy: mix.item2,
            //   estatus: mix.item3,
            //   usuario: user,
            // );
          },
          nextPageKeyBuilder: NextPageKeyBuilderDefault.mysqlPagination,
        );

  void selectAll(bool selectAll) {
    final nuevaLista = state.records?.map((recurso) {
      recurso.select = selectAll;
      return recurso;
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

  Future<bool> delete() async {
    for (var element in state.records ?? List<Notificacion>.empty()) {
      if (element.select) {
        final status = await NotificacionService().delete(element);

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
          message: "Notificaciones eliminadas correctamente",
          type: TypeSnackbar.success,
          withIcon: true,
          maxLines: 2,
        );
    return false;
  }

  Future<bool> markRead() async {
    for (var element in state.records ?? List<Notificacion>.empty()) {
      if (element.estatus == 'Enviado') {
        Notificacion selectNotification = Notificacion();
        selectNotification.id = element.id;
        selectNotification.estatus = "Leido";

        final status = await NotificacionService()
            .saveData(notificacion: selectNotification);

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
          message: "Notificaciones marcadas correctamente",
          type: TypeSnackbar.success,
          withIcon: true,
          maxLines: 2,
        );
    return false;
  }
}

final notificacionesProvider = StateNotifierProvider.family<
    NotificacionesNotifier, PagedState<int, Notificacion>, String>((ref, mix) {
  final search = ref.watch(searchNotProvider).text;
  final filter = ref.watch(filterNotProvider);
  final keyList = ref.watch(keyNotListProvider);

  final arg = Tuple4(
    search,
    filter.orderBy.toString(),
    filter.status,
    keyList,
  );

  return NotificacionesNotifier(ref, arg);
});

final notificacionProvider = StateProvider<Notificacion?>((ref) => null);

final saveNotificationProvider = FutureProvider<bool>(
  (ref) async {
    final notification = ref.watch(notificacionProvider);

    if (notification != null) {
      final response =
          await NotificacionService().saveData(notificacion: notification);

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
                  "Notificacion ${notification.id != null ? "actualizada" : "creada"} correctamente",
              duration: const Duration(seconds: 3),
              type: TypeSnackbar.success,
              withIcon: true,
            );
      }

      return false;
    } else {
      return false;
    }
  },
);

final deleteNotificationProvider = FutureProvider<bool>(
  (ref) async {
    final notification = ref.watch(notificacionProvider);

    if (notification != null) {
      final response = await NotificacionService().delete(notification);

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
            message: "Notificacion eliminada correctamente",
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

final keyNotListProvider = StateProvider<String>((ref) {
  return UniqueKey().hashCode.toString();
});

final updateViewNotificationListProvider = StateProvider<String>((ref) {
  return UniqueKey().hashCode.toString();
});

class NotificacionProvider extends StateNotifier<List<Notificacion>> {
  NotificacionProvider() : super([]);

  static final provider =
      StateNotifierProvider<NotificacionProvider, List<Notificacion>>(
          (ref) => NotificacionProvider());

  Notificacion _current = Notificacion();
  Notificacion get current => _current;

  void addItem(Notificacion item) {
    _current = item;
    state = [...state, item];
  }

  void editItem(Notificacion item) {
    int index = state.indexWhere((element) => element.idInt == item.idInt);
    if (index != -1) {
      state[index] = item;
    }
  }

  void remove(int id) {
    state = [...state.where((element) => element.idInt != id)];
  }

  void clear() => state = [];
}

final userViewProvider = StateProvider<bool>((ref) => false);
