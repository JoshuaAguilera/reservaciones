import 'package:flutter/material.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/views/tarifario/tarifario_calendary_view.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../ui/custom_widgets.dart';
import '../../ui/title_page.dart';
import '../../widgets/custom_dropdown.dart';

class TarifarioView extends StatefulWidget {
  const TarifarioView({super.key, required this.sideController});
  final SidebarXController sideController;

  @override
  State<TarifarioView> createState() => _TarifarioViewState();
}

class _TarifarioViewState extends State<TarifarioView> {
  String typePeriod = filtrosRegistro.first;
  final List<bool> selectedMode = <bool>[
    true,
    false,
    false,
  ];

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
              TitlePage(
                title: "Tarifario",
                subtitle:
                    "Contempla, analiza y define las principales tarifas de planes, habitaciones, PAX y promociones para complementar la generación de cotizaciones.",
                childOptional: Buttons.commonButton(
                  onPressed: () {},
                  text: "Crear tarifa",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDropdown.dropdownMenuCustom(
                      fontSize: 12,
                      initialSelection: typePeriod,
                      onSelected: (String? value) {
                        setState(() {
                          typePeriod = value!;
                        });
                      },
                      elements: filtrosRegistro,
                      screenWidth: null),
                  CustomWidgets.sectionButton(
                    selectedMode,
                    modesVisual,
                    (p0, p1) {
                      selectedMode[p0] = p0 == p1;
                      setState(() {});
                    },
                  ),
                ],
              ),
              TarifarioCalendaryView(),
            ],
          ),
        ),
      ),
    );
  }
}
