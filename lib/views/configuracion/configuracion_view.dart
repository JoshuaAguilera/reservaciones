import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/views/configuracion/config_general_view.dart';

import '../../ui/buttons.dart';
import '../../widgets/text_styles.dart';

class ConfiguracionView extends StatefulWidget {
  const ConfiguracionView({super.key});

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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextStyles.titlePagText(text: "Configuración"),
              ]),
              TextStyles.standardText(
                  text:
                      "Administrar la configuración y preferencias de su cuenta"),
              const Divider(color: Colors.black54),
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
                                      style: TextStyle(color: Colors.white),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    switch (typeSettings) {
                      case "Generales":
                        return ConfigGeneralView();
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
