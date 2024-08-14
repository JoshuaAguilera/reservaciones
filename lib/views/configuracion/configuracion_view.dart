import 'package:flutter/material.dart';
import 'package:generador_formato/ui/title_page.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/views/configuracion/config_formato_group_view.dart';
import 'package:generador_formato/views/configuracion/config_general_view.dart';
import 'package:generador_formato/views/configuracion/preferencias_config_view.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../ui/buttons.dart';
import '../../widgets/text_styles.dart';
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
                      "Administrar la configuración y preferencias de su interfaz y documentos."),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 0,
                  color: Colors.grey[300],
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
                                    color: Colors.grey[600],
                                    round: 4,
                                    roundActive: 6,
                                    selected: setting == typeSettings[index],
                                    onPressed: () {
                                      setState(() {
                                        setting = typeSettings[index];
                                      });
                                    },
                                    child: Text(
                                      typeSettings[index],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    switch (setting) {
                      case "Generales":
                        return ConfigGeneralView();
                      case "Formato Individual":
                        return ConfigFormatoIndView(
                            sideController: widget.sideController);
                      case "Formato Grupal":
                        return ConfigFormatoGroupView(
                            sideController: widget.sideController);
                      case "Planes y categorias":
                        return PreferenciasConfigView();
                      default:
                        return ConfigGeneralView();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
