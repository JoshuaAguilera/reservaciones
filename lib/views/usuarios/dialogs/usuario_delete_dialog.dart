import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tuple/tuple.dart';

import '../../../models/usuario_model.dart';
import '../../../res/ui/custom_dialog.dart';
import '../../../view-models/providers/gestion_usuario_provider.dart';
import '../../../view-models/providers/usuario_provider.dart';

class UsuarioDeleteDialog extends ConsumerWidget {
  final Usuario? usuario;
  final bool isRemove;

  const UsuarioDeleteDialog({
    super.key,
    this.usuario,
    this.isRemove = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterList = ref.watch(filterUMProvider);
    final keyList = ref.watch(keyUserListProvider);
    final keyReduceList = ref.watch(keyReduceListProvider);

    return CustomDialog(
      title: "Eliminar usuario",
      withButtonSecondary: true,
      notCloseInstant: true,
      contentString:
          "¿Desea eliminar ${isRemove ? "" : "definitivamente"} ${usuario != null ? "el usuario ${usuario?.username}" : "estos usuarios"} del sistema?",
      icon: Iconsax.trash_outline,
      withLoadingProcess: true,
      funtion1: () async {
        if (usuario != null) {
          ref.read(usuarioProvider.notifier).update((state) => usuario);

          bool responseUser = await (!isRemove
              ? ref.read(deleteUserProvider.future)
              : ref.read(setStatusUserProvider.future));

          if (responseUser) return;
        } else {
          bool response;
          if (isRemove) {
            response = await ref
                .read(usuariosProvider(
                  Tuple4(
                    "",
                    filterList.orderByUser ?? '',
                    keyList,
                    "registrado",
                  ),
                ).notifier)
                .deleteUser();
          } else {
            response = await ref
                .read(
                  usuariosDeclinadosProvider(
                    Tuple4(
                      "",
                      "",
                      keyReduceList,
                      "inactivo",
                    ),
                  ).notifier,
                )
                .deleteUser(onlyRemove: false);
          }

          if (response) return;

          ref.read(selectAllItemsUMProvider.notifier).update((state) => false);
          ref.read(selectItemsUMProvider.notifier).update((state) => false);
        }

        ref.read(usuarioProvider.notifier).update((state) => null);

        if (isRemove) {
          ref.read(keyUserListProvider.notifier).update((state) {
            return UniqueKey().hashCode.toString();
          });

          ref.invalidate(usuariosDeclinadosProvider);
        } else {
          ref.read(keyReduceListProvider.notifier).update((state) {
            return UniqueKey().hashCode.toString();
          });
        }

        if (!context.mounted) return;
        Navigator.of(context).pop(true);
      },
    );
  }
}
