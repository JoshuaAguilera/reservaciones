import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/ui/title_page.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/views/configuracion/config_SMTP_view.dart';
import 'package:generador_formato/views/configuracion/config_formato_group_view.dart';
import 'package:generador_formato/views/configuracion/config_general_view.dart';
import 'package:generador_formato/views/configuracion/help_resource_view.dart';
import 'package:generador_formato/views/configuracion/preferencias_config_view.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../ui/buttons.dart';
import '../../utils/shared_preferences/settings.dart';
import 'config_formato_ind_view.dart';

class ConfiguracionView extends StatefulWidget {
  const ConfiguracionView({super.key, required this.sideController});

  final SidebarXController sideController;

  @override
  State<ConfiguracionView> createState() => _ConfiguracionViewState();
}

class _ConfiguracionViewState extends State<ConfiguracionView> {
  String setting = typeSettings.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitlePage(
                title: "Configuración",
                subtitle:
                    "Administrar la configuración y preferencias de su interfaz y servicios.",
              ).animate().fadeIn(
                    duration: Settings.applyAnimations ? null : 0.ms,
                  ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(
                    height: 30,
                    child: StatefulBuilder(
                      builder: (context, snapshot) {
                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: typeSettings.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
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
              ).animate().fadeIn(
                    delay: !Settings.applyAnimations ? null : 150.ms,
                    duration: Settings.applyAnimations ? null : 0.ms,
                  ),
              SizedBox(
                width: double.infinity,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    switch (setting) {
                      case "Generales":
                        return const ConfigGeneralView();
                      case "Servidor SMTP":
                        return const ConfigSMTPView();
                      case "Ayuda y manuales":
                        return const HelpResourseView();
                      case "Formato Individual":
                        return ConfigFormatoIndView(
                            sideController: widget.sideController);
                      case "Formato Grupal":
                        return ConfigFormatoGroupView(
                            sideController: widget.sideController);
                      case "Planes y categorias":
                        return PreferenciasConfigView();
                      default:
                        return const ConfigGeneralView();
                    }
                  },
                ),
              ).animate().fadeIn(
                    delay: !Settings.applyAnimations ? null : 350.ms,
                    duration: Settings.applyAnimations ? null : 0.ms,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
