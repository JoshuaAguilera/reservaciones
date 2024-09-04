import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../ui/custom_widgets.dart';
import '../../ui/title_page.dart';
import 'tarifario_calendary_week_view.dart';

class TarifarioView extends ConsumerStatefulWidget {
  const TarifarioView({super.key, required this.sideController});
  final SidebarXController sideController;

  @override
  _TarifarioViewState createState() => _TarifarioViewState();
}

class _TarifarioViewState extends ConsumerState<TarifarioView> {
  String typePeriod = filtrosRegistro.first;
  bool target = false;
  bool targetForm = false;
  bool showForm = true;
  bool inMenu = false;
  int yearNow = DateTime.now().year;

  final List<bool> selectedModeView = <bool>[
    true,
    false,
    false,
  ];

  final List<bool> selectedModeCalendar = <bool>[
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
                childOptional: !showForm
                    ? const SizedBox()
                    : SizedBox(
                        height: 38,
                        child: Buttons.commonButton(
                          onPressed: () {
                            onCreate.call();
                          },
                          text: "Crear tarifa",
                        ).animate(target: !targetForm ? 1 : 0).fadeIn(),
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        child: CustomWidgets.sectionButton(
                          listModes: selectedModeCalendar,
                          modesVisual: [],
                          onChanged: (p0, p1) {
                            selectedModeCalendar[p0] = p0 == p1;
                            if (selectedModeCalendar[0]) {
                              yearNow = DateTime.now().year;
                            }
                            setState(() {});
                          },
                          arrayStrings: filtrosRegistro,
                          borderRadius: 12,
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (screenWidth < 1280 && inMenu)
                        ElevatedButton(
                          onPressed: () {
                            if (targetForm) {
                              setState(() => targetForm = !targetForm);

                              Future.delayed(Durations.extralong1,
                                  () => setState(() => showForm = !showForm));
                            }

                            setState(() {
                              target = false;
                            });

                            Future.delayed(
                              700.ms,
                              () => setState(() => inMenu = false),
                            );
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
                    ],
                  ),
                  CustomWidgets.sectionButton(
                    listModes: selectedModeView,
                    modesVisual: modesVisual,
                    onChanged: (p0, p1) {
                      selectedModeView[p0] = p0 == p1;
                      setState(() {});
                    },
                  ),
                ],
              ),
              TarifarioCalendaryView(
                target: target,
                inMenu: inMenu,
                sideController: widget.sideController,
                viewWeek: selectedModeCalendar[0],
                viewMonth: selectedModeCalendar[1],
                viewYear: selectedModeCalendar[2],
                yearNow: yearNow,
                targetForm: targetForm,
                showForm: showForm,
                onCreate: () => onCreate.call(),
                onTarget: () {
                  setState(() => target = true);

                  Future.delayed(Durations.extralong1,
                      () => setState(() => inMenu = true));
                },
                onTargetForm: () {
                  setState(() => targetForm = !targetForm);

                  Future.delayed(Durations.extralong1,
                      () => setState(() => showForm = !showForm));
                },
                increaseYear: () => setState(() => yearNow++),
                reduceYear: () => setState(() => yearNow--),
                setYear: (p0) => setState(() => yearNow = p0),
              ),
            ],
          ),
        ),
      ),
    ).animate(target: targetForm ? 0 : 1).fadeIn();
  }

  void Function()? onCreate() {
    setState(() {
      targetForm = true;
    });
    Future.delayed(500.ms, () => widget.sideController.selectIndex(15));
  }
}
