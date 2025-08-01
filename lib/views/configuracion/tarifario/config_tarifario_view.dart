import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../res/helpers/animation_helpers.dart';
import '../../../res/ui/section_container.dart';
import 'config_tar_list.dart';

class ConfigTarifarioView extends ConsumerStatefulWidget {
  const ConfigTarifarioView({super.key});

  @override
  ConsumerState<ConfigTarifarioView> createState() =>
      _ConfigTarifarioViewState();
}

class _ConfigTarifarioViewState extends ConsumerState<ConfigTarifarioView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedEntry(
      child: SectionContainer(
        padH: 18,
        spacing: 20,
        title: "Tarifario",
        subtitle:
            "Configura los tipos y categorias de habitaciones del Tarifario.",
        // isModule: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        children: const [
          TipoHabitacionList(),
          CategoriasList(),
        ],
      ),
    );
  }
}
