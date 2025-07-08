import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tuple/tuple.dart';

import '../../../models/rol_model.dart';
import '../../../res/ui/custom_dialog.dart';
import '../../../view-models/providers/gestion_usuario_provider.dart';
import '../../../view-models/providers/rol_provider.dart';
import '../../../view-models/providers/usuario_provider.dart';

class RolDeleteDialog extends ConsumerWidget {
  final Rol? rol;
  final bool isRemove;

  const RolDeleteDialog({
    super.key,
    this.rol,
    this.isRemove = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterList = ref.watch(filterUMProvider);
    final keyList = ref.watch(keyRoleListProvider);

    return CustomDialog(
      title: "Eliminar rol",
      withButtonSecondary: true,
      notCloseInstant: true,
      contentString:
          "¿Desea eliminar ${rol != null ? "el rol ${rol?.nombre}" : "estos roles"} del sistema?",
      icon: Iconsax.trash_outline,
      withLoadingProcess: true,
      funtion1: () async {
        if (rol != null) {
          ref.read(rolProvider.notifier).update((state) => rol);

          bool responseUser = await ref.read(deleterRolProvider.future);

          if (responseUser) return;
        } else {
          bool response = await ref
              .read(rolesProvider(
                Tuple3(
                  "",
                  filterList.orderByRole ?? '',
                  keyList,
                ),
              ).notifier)
              .deleteSelection();

          if (response) return;
          ref.read(selectAllItemsUMProvider.notifier).update((state) => false);
          ref.read(selectItemsUMProvider.notifier).update((state) => false);
        }

        ref.read(rolProvider.notifier).update((state) => null);

        ref.read(keyRoleListProvider.notifier).update((state) {
          return UniqueKey().hashCode.toString();
        });
        // ref.invalidate(rolProvider);
        ref.invalidate(rolesReqProvider);
        ref.invalidate(usuariosProvider);

        if (!context.mounted) return;
        Navigator.of(context).pop(true);
      },
    );
  }
}
