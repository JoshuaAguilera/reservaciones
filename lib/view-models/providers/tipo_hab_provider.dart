import 'package:riverpod/riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../models/estatus_snackbar_model.dart';
import '../../models/tipo_habitacion_model.dart';
import '../services/tipo_hab_service.dart';
import 'ui_provider.dart';

final tipoHabListProvider =
    FutureProvider.family<List<TipoHabitacion>, Tuple3<String, int, int>?>(
        (ref, arg) async {
  var nombre = arg?.item1 ?? "";
  var page = arg?.item2 ?? 0;
  var limit = arg?.item3 ?? 100;

  final list = await TipoHabService().getList(
    codigo: nombre,
    page: page,
    limit: limit,
  );
  return list;
});

final tipoHabitacionProvider = StateProvider<TipoHabitacion?>((ref) => null);

final saveTipoHabitacionProvider = FutureProvider<bool>(
  (ref) async {
    final tipoHabitacion = ref.watch(tipoHabitacionProvider);

    if (tipoHabitacion != null) {
      final response = await TipoHabService().saveData(tipoHabitacion);
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
                  "Tipo de Habitación ${tipoHabitacion.id != null ? "actualizado" : "creado"} correctamente",
              type: TypeSnackbar.success,
              withIcon: true,
            );
      }
      return false;
    }
    return false;
  },
);

final deleteTipoHabitacionProvider = FutureProvider<bool>(
  (ref) async {
    final tipoHabitacion = ref.watch(tipoHabitacionProvider);

    if (tipoHabitacion != null) {
      final response = await TipoHabService().delete(tipoHabitacion);
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
            message: "Tipo de Habitación eliminada correctamente",
            type: TypeSnackbar.success,
            withIcon: true,
          );

      return false;
    } else {
      return false;
    }
  },
);
