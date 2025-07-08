import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../models/estatus_snackbar_model.dart';
import '../../models/imagen_model.dart';
import '../../res/helpers/utility.dart';
import '../services/imagen_service.dart';
import 'ui_provider.dart';
import 'usuario_provider.dart';

final imagenProvider = StateProvider<Imagen?>((ref) => null);

final saveimagenProvider = FutureProvider<Tuple2<bool, Imagen?>>(
  (ref) async {
    final image = ref.watch(imagenProvider);
    final imagePerfil = ref.watch(imagePerfilProvider);

    if (image != null) {
      double? size = Utility.getFileSizeMB(image.newImage!);
      if (size > 10) {
        ref.read(snackbarServiceProvider).showCustomSnackBar(
              message: "El tamaño de la imagen no puede ser mayor a 10 MB",
              type: TypeSnackbar.danger,
              withIcon: true,
            );

        ref.read(imagenProvider.notifier).update((state) => null);
        return const Tuple2(true, null);
      }

      final response = await ImagenService().saveData(imagen: image);

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
              message:
                  "Imagen ${image.idInt == imagePerfil?.idInt ? "de perfil" : ""}${image.idInt != null ? "actualizada" : "creada"} correctamente",
              type: TypeSnackbar.success,
              withIcon: true,
            );
      }

      return Tuple2(false, response.item2);
    } else {
      return const Tuple2(false, null);
    }
  },
);

final deleterimagenProvider = FutureProvider<bool>(
  (ref) async {
    final image = ref.watch(imagenProvider);

    if (image != null) {
      final response = await ImagenService().delete(image);

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
            message: "Imagen eliminada correctamente",
            type: TypeSnackbar.success,
            withIcon: true,
          );

      return false;
    } else {
      return false;
    }
  },
);
