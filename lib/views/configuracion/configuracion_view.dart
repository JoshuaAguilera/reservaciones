import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../res/helpers/animation_helpers.dart';
import '../../res/helpers/constants.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/page_base.dart';
import '../../res/ui/section_container.dart';
import 'config_SMTP_view.dart';
import 'config_general_view.dart';
import 'help_resource_view.dart';
import 'tarifario/config_tarifario_view.dart';

class ConfiguracionView extends ConsumerStatefulWidget {
  const ConfiguracionView({super.key});

  @override
  ConsumerState<ConfiguracionView> createState() => _ConfiguracionViewState();
}

class _ConfiguracionViewState extends ConsumerState<ConfiguracionView> {
  String setting = typeSettings.first;

  @override
  Widget build(BuildContext context) {
    return PageBase(
      children: [
        SectionContainer(
          spacing: 10,
          title: "Configuración",
          subtitle:
              "Administrar la configuración y preferencias de su interfaz y servicios.",
          children: [
            AnimatedEntry(
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: StatefulBuilder(
                  builder: (context, snapshot) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: typeSettings.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: SelectableButton(
                            elevation: 3,
                            round: 4,
                            roundActive: 6,
                            selected: setting == typeSettings[index],
                            onPressed: () {
                              setState(() {
                                setting = typeSettings[index];
                              });
                            },
                            child: Text(typeSettings[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            AnimatedEntry(
              child: SizedBox(
                width: double.infinity,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    switch (setting) {
                      case "Generales":
                        return const ConfigGeneralView();
                      case "Servidor SMTP":
                        return const ConfigSMTPView();
                      case "Ayuda y manuales":
                        return const HelpResourceView();
                      case "Tarifario":
                        return const ConfigTarifarioView();
                      // case "Formato Individual":
                      //   return ConfigFormatoIndView(
                      //       sideController: sideController);
                      // case "Formato Grupal":
                      //   return ConfigFormatoGroupView(
                      //       sideController: sideController);
                      default:
                        return const ConfigGeneralView();
                    }
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
