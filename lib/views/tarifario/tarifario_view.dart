import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/views/tarifario/tarifario_calendary_view.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../ui/custom_widgets.dart';
import '../../ui/title_page.dart';
import '../../widgets/custom_dropdown.dart';

class TarifarioView extends ConsumerStatefulWidget {
  const TarifarioView({super.key, required this.sideController});
  final SidebarXController sideController;

  @override
  _TarifarioViewState createState() => _TarifarioViewState();
}

class _TarifarioViewState extends ConsumerState<TarifarioView> {
  String typePeriod = filtrosRegistro.first;
  bool target = false;
  final List<bool> selectedMode = <bool>[
    true,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                childOptional: SizedBox(
                  height: 38,
                  child: Buttons.commonButton(
                    onPressed: () {},
                    text: "Crear tarifa",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (screenWidth < 1280)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              target = false;
                            });
                          },
                          style: ButtonStyle(
                            padding:
                                const WidgetStatePropertyAll(EdgeInsets.zero),
                            backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).cardColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Icon(
                              Icons.menu_rounded,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                          ),
                        )
                            .animate(target: target ? 1 : 0)
                            .slideX(begin: -0.2, duration: 550.ms)
                            .fadeIn(delay: !target ? 0.ms : 400.ms),
                      const SizedBox(width: 10),
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
                    
                    ],
                  ),
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
              TarifarioCalendaryView(
                target: target,
                onTarget: () {
                  setState(() {
                    target = true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
