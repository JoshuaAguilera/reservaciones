import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/periodo_model.dart';
import 'package:generador_formato/models/tarifa_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/providers/tarifario_provider.dart';
import 'package:generador_formato/services/tarifa_service.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/utils/shared_preferences/preferences.dart';
import 'package:generador_formato/widgets/item_row.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../ui/custom_widgets.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/text_styles.dart';
import '../../widgets/textformfield_custom.dart';

class FormTarifarioView extends ConsumerStatefulWidget {
  const FormTarifarioView({Key? key, required this.sideController})
      : super(key: key);

  final SidebarXController sideController;

  @override
  _FormTarifarioViewState createState() => _FormTarifarioViewState();
}

class _FormTarifarioViewState extends ConsumerState<FormTarifarioView> {
  final _formKeyTarifa = GlobalKey<FormState>();
  String type = tipoHabitacion.first;
  String plan = planes.first;
  bool inAllPeriod = false;
  bool autoCalculationVR = true;
  bool autoCalculationVPM = true;
  double target = 1;
  Color colorTarifa = Colors.amber;
  TextEditingController nombreTarifaController = TextEditingController();
  TextEditingController _fechaEntrada = TextEditingController(text: "");
  TextEditingController _fechaSalida = TextEditingController(text: "");
  String codeTarifa =
      "${UniqueKey()} - ${Preferences.username} - ${Preferences.userId} - ${DateTime.now().toString()}";
  TextEditingController estanciaPromController = TextEditingController();
  TextEditingController estanciaBar1Controller = TextEditingController();
  TextEditingController estanciaBar2Controller = TextEditingController();
  TextEditingController promocionController = TextEditingController();
  TextEditingController bar1Controller = TextEditingController();
  TextEditingController bar2Controller = TextEditingController();
  TextEditingController adults1_2VRController = TextEditingController();
  TextEditingController adults3VRController = TextEditingController(text: "0");
  TextEditingController adults4VRController = TextEditingController(text: "0");
  TextEditingController paxAdicVRController = TextEditingController();
  TextEditingController minors7_12VRController = TextEditingController();
  TextEditingController adults1_2VPMController = TextEditingController();
  TextEditingController adults3VPMController = TextEditingController(text: "0");
  TextEditingController adults4VPMController = TextEditingController(text: "0");
  TextEditingController paxAdicVPMController = TextEditingController();
  TextEditingController minors7_12VPMController = TextEditingController();

  List<Periodo> periodos = [];

  final List<bool> selectedDayWeek = <bool>[
    true,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  void resetDates() {
    _fechaEntrada =
        TextEditingController(text: DateTime.now().toString().substring(0, 10));
    _fechaSalida = TextEditingController(
        text: DateTime.now()
            .add(const Duration(days: 1))
            .toString()
            .substring(0, 10));
    setState(() {});
  }

  @override
  void initState() {
    resetDates();
    super.initState();
  }

  @override
  void dispose() {
    nombreTarifaController.dispose();
    _fechaEntrada.dispose();
    _fechaSalida.dispose();
    promocionController.dispose();
    bar1Controller.dispose();
    bar2Controller.dispose();
    adults1_2VRController.dispose();
    adults3VRController.dispose();
    adults4VRController.dispose();
    paxAdicVRController.dispose();
    minors7_12VRController.dispose();
    adults1_2VPMController.dispose();
    adults3VPMController.dispose();
    adults4VPMController.dispose();
    paxAdicVPMController.dispose();
    minors7_12VPMController.dispose();
    estanciaPromController.dispose();
    estanciaBar1Controller.dispose();
    estanciaBar2Controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKeyTarifa,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() => target = 0);

                            Future.delayed(500.ms,
                                () => widget.sideController.selectIndex(5));
                          },
                          iconSize: 30,
                          icon: Icon(
                            CupertinoIcons.chevron_left_circle,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                        ),
                        TextStyles.titlePagText(
                          text: "Crear tarifa",
                          overflow: TextOverflow.ellipsis,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                      width: 130,
                      child: Buttons.commonButton(
                        onPressed: () async {
                          await savedTariff();
                        },
                        sizeText: 15,
                        text: "Guardar",
                      ),
                    ),
                  ],
                ),
                Divider(color: Theme.of(context).primaryColor),
                const SizedBox(height: 10),
                Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextStyles.titleText(
                              text: "Datos generales",
                              size: 18,
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          Wrap(
                            runSpacing: 15,
                            spacing: 20,
                            children: [
                              SizedBox(
                                width: 500,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: TextFormFieldCustom
                                          .textFormFieldwithBorder(
                                        name: "Nombre de la tarifa Rack",
                                        controller: nombreTarifaController,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: FormWidgets.inputColor(
                                        nameInput: "Color:",
                                        primaryColor: colorTarifa,
                                        colorText:
                                            Theme.of(context).primaryColor,
                                        onChangedColor: (p0) =>
                                            setState(() => colorTarifa = p0),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 500,
                                child: AbsorbPointer(
                                  absorbing: inAllPeriod,
                                  child: Opacity(
                                    opacity: inAllPeriod ? 0.5 : 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextStyles.standardText(
                                            text: "Dias de aplicación:",
                                            color:
                                                Theme.of(context).primaryColor),
                                        CustomWidgets.sectionButton(
                                          listModes: selectedDayWeek,
                                          modesVisual: [],
                                          onChanged: (p0, p1) {},
                                          isReactive: false,
                                          isCompact: true,
                                          arrayStrings: daysNameShort,
                                          borderRadius: 12,
                                          selectedBorderColor: colorTarifa,
                                          selectedColor: Color.fromARGB(
                                              20,
                                              colorTarifa.blue,
                                              colorTarifa.green,
                                              colorTarifa.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              FormWidgets.inputSwitch(
                                  value: inAllPeriod,
                                  context: context,
                                  activeColor: colorTarifa,
                                  onChanged: (p0) => setState(() {
                                        inAllPeriod = !inAllPeriod;
                                        selectedDayWeek.clear();
                                        selectedDayWeek.addAll([
                                          true,
                                          inAllPeriod,
                                          inAllPeriod,
                                          inAllPeriod,
                                          inAllPeriod,
                                          inAllPeriod,
                                          inAllPeriod
                                        ]);
                                      }),
                                  name: "Aplicar en todo el periodo"),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12, top: 10),
                            child: TextStyles.titleText(
                              text: "Periodos",
                              size: 18,
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          SizedBox(
                            width: 800,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextFormFieldCustom
                                      .textFormFieldwithBorderCalendar(
                                    name: "Fecha de entrada",
                                    msgError: "Campo requerido*",
                                    fechaLimite:
                                        DateTime(DateTime.now().year, 1, 1)
                                            .subtract(const Duration(days: 1))
                                            .toIso8601String(),
                                    dateController: _fechaEntrada,
                                    onChanged: () => setState(
                                      () {
                                        if (DateTime.parse(_fechaSalida.text)
                                            .isBefore(DateTime.parse(
                                                _fechaEntrada.text))) {
                                          _fechaSalida.text =
                                              Utility.getNextDay(
                                                  _fechaEntrada.text);
                                          setState(() {});
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: TextFormFieldCustom
                                      .textFormFieldwithBorderCalendar(
                                    name: "Fecha de salida",
                                    msgError: "Campo requerido*",
                                    dateController: _fechaSalida,
                                    fechaLimite:
                                        DateTime.parse(_fechaEntrada.text)
                                            .subtract(const Duration(days: 1))
                                            .toIso8601String(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    if (!evaluatedDates(
                                        periodos,
                                        _fechaEntrada.text,
                                        _fechaSalida.text)) {
                                      periodos.add(
                                        Periodo(
                                          fechaInicial: DateTime.parse(
                                              _fechaEntrada.text),
                                          fechaFinal:
                                              DateTime.parse(_fechaSalida.text),
                                        ),
                                      );
                                      setState(() {});
                                      resetDates();
                                    } else {
                                      showSnackBar(
                                        context: context,
                                        title: "Concurrencia de periodo",
                                        message:
                                            "Ya existe un periodo que contempla estas fechas de implementación",
                                        type: "alert",
                                      );
                                    }
                                  },
                                  style: ButtonStyle(
                                    padding: const WidgetStatePropertyAll(
                                        EdgeInsets.zero),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Theme.of(context).primaryColorDark),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Icon(
                                      Icons.add,
                                      size: 30,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: SizedBox(
                              child: Wrap(
                                children: [
                                  for (var element in periodos)
                                    ItemRow.filterItemRow(
                                      colorCard: colorTarifa,
                                      initDate: element.fechaInicial!,
                                      lastDate: element.fechaFinal!,
                                      onRemove: () {
                                        periodos.remove(element);
                                        setState(() {});
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 1),
                          child: TextStyles.titleText(
                            text: "Configuración de temporadas",
                            size: 18,
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              SizedBox(
                                width: getWidthResizableTemporada(screenWidth),
                                child: CustomWidgets.sectionConfigSeason(
                                  title: "Promoción",
                                  context: context,
                                  estanciaController: estanciaPromController,
                                  promocionController: promocionController,
                                  onChanged: (p0) {
                                    bar1Controller.text =
                                        (Utility.parseDoubleText(p0) + 1)
                                            .toString();
                                    bar2Controller.text =
                                        (Utility.parseDoubleText(p0) + 2)
                                            .toString();
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(
                                width: getWidthResizableTemporada(screenWidth),
                                child: CustomWidgets.sectionConfigSeason(
                                  title: "BAR I",
                                  context: context,
                                  estanciaController: estanciaBar1Controller,
                                  promocionController: bar1Controller,
                                  onChanged: (p0) {
                                    bar1Controller.text =
                                        (Utility.parseDoubleText(p0) + 1)
                                            .toString();
                                    bar2Controller.text =
                                        (Utility.parseDoubleText(p0) + 2)
                                            .toString();
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(
                                width: getWidthResizableTemporada(screenWidth),
                                child: CustomWidgets.sectionConfigSeason(
                                  title: "BAR II",
                                  context: context,
                                  estanciaController: estanciaBar2Controller,
                                  promocionController: bar2Controller,
                                  onChanged: (p0) {
                                    bar1Controller.text =
                                        (Utility.parseDoubleText(p0) + 1)
                                            .toString();
                                    bar2Controller.text =
                                        (Utility.parseDoubleText(p0) + 2)
                                            .toString();
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 1),
                          child: TextStyles.titleText(
                            text: "Tarífas",
                            size: 18,
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Wrap(
                            runSpacing: 15,
                            spacing: 15,
                            children: [
                              SizedBox(
                                width: getWidthResizableTarifa(screenWidth),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: DesktopColors.vistaReserva,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Wrap(
                                          alignment: getWrapAligmentContainer(
                                              screenWidth),
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          runAlignment: WrapAlignment.center,
                                          children: [
                                            TextStyles.mediumText(
                                              text: "VISTA RESERVA",
                                              color: Colors.white,
                                            ),
                                            FormWidgets.inputSwitch(
                                              name: "Auto calculación:",
                                              context: context,
                                              value: autoCalculationVR,
                                              activeColor: Colors.white,
                                              onChanged: (p0) => setState(
                                                  () => autoCalculationVR = p0),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FormWidgets
                                              .textFormFieldResizable(
                                            name: "SGL/DBL",
                                            isDecimal: true,
                                            isNumeric: true,
                                            isMoneda: true,
                                            controller: adults1_2VRController,
                                            onChanged: (p0) {
                                              if (autoCalculationVR) {
                                                adults3VRController.text =
                                                    Utility.calculateRate(
                                                        adults1_2VRController,
                                                        paxAdicVRController,
                                                        1);
                                                adults4VRController.text =
                                                    Utility.calculateRate(
                                                        adults1_2VRController,
                                                        paxAdicVRController,
                                                        2);
                                              }
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: FormWidgets
                                              .textFormFieldResizable(
                                            name: "PAX ADIC",
                                            isDecimal: true,
                                            isNumeric: true,
                                            isMoneda: true,
                                            controller: paxAdicVRController,
                                            onChanged: (p0) {
                                              if (autoCalculationVR) {
                                                adults3VRController.text =
                                                    Utility.calculateRate(
                                                        adults1_2VRController,
                                                        paxAdicVRController,
                                                        1);
                                                adults4VRController.text =
                                                    Utility.calculateRate(
                                                        adults1_2VRController,
                                                        paxAdicVRController,
                                                        2);
                                              }
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Opacity(
                                      opacity: autoCalculationVR ? 0.5 : 1,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: FormWidgets
                                                .textFormFieldResizable(
                                              name: "TPL",
                                              isDecimal: true,
                                              isNumeric: true,
                                              isMoneda: true,
                                              blocked: autoCalculationVR,
                                              controller: adults3VRController,
                                              onChanged: (p0) {
                                                if (!autoCalculationVR) {
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: FormWidgets
                                                .textFormFieldResizable(
                                              name: "CPLE",
                                              isDecimal: true,
                                              isNumeric: true,
                                              isMoneda: true,
                                              blocked: autoCalculationVR,
                                              controller: adults4VRController,
                                              onChanged: (p0) {
                                                if (!autoCalculationVR) {
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FormWidgets
                                              .textFormFieldResizable(
                                            name: "MENORES 7 A 12 AÑOS",
                                            isDecimal: true,
                                            isNumeric: true,
                                            isMoneda: true,
                                            controller: minors7_12VRController,
                                            onChanged: (p0) => setState(() {}),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: FormWidgets
                                              .textFormFieldResizable(
                                            name: "MENORES 0 A 6 AÑOS",
                                            isDecimal: true,
                                            initialValue: "GRATIS",
                                            isNumeric: true,
                                            // isMoneda: true,
                                            blocked: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CustomWidgets.expansionTileCustomTarifa(
                                      colorTarifa: colorTarifa,
                                      nameTile: "Promoción",
                                      context: context,
                                      promocionController: promocionController,
                                      estanciaController:
                                          estanciaPromController,
                                      adults1_2Controller:
                                          adults1_2VRController,
                                      paxAdicController: paxAdicVRController,
                                      adults3Controller: adults3VRController,
                                      adults4Controller: adults4VRController,
                                      minors7_12Controller:
                                          minors7_12VRController,
                                      onChanged: (p0) {
                                        bar1Controller.text =
                                            (Utility.parseDoubleText(p0) + 1)
                                                .toString();
                                        bar2Controller.text =
                                            (Utility.parseDoubleText(p0) + 2)
                                                .toString();
                                        setState(() {});
                                      },
                                    ),
                                    CustomWidgets.expansionTileCustomTarifa(
                                      colorTarifa: colorTarifa,
                                      nameTile: "BAR I",
                                      context: context,
                                      promocionController: bar1Controller,
                                      estanciaController:
                                          estanciaBar1Controller,
                                      adults1_2Controller:
                                          adults1_2VRController,
                                      paxAdicController: paxAdicVRController,
                                      adults3Controller: adults3VRController,
                                      adults4Controller: adults4VRController,
                                      minors7_12Controller:
                                          minors7_12VRController,
                                    ),
                                    CustomWidgets.expansionTileCustomTarifa(
                                      colorTarifa: colorTarifa,
                                      nameTile: "BAR II",
                                      context: context,
                                      promocionController: bar2Controller,
                                      estanciaController:
                                          estanciaBar2Controller,
                                      adults1_2Controller:
                                          adults1_2VRController,
                                      paxAdicController: paxAdicVRController,
                                      adults3Controller: adults3VRController,
                                      adults4Controller: adults4VRController,
                                      minors7_12Controller:
                                          minors7_12VRController,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: getWidthResizableTarifa(screenWidth),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: DesktopColors.vistaParcialMar,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Wrap(
                                          alignment: getWrapAligmentContainer(
                                              screenWidth),
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          runAlignment: WrapAlignment.center,
                                          children: [
                                            TextStyles.mediumText(
                                              text: "VISTA PARCIAL AL MAR",
                                              color: Colors.white,
                                            ),
                                            FormWidgets.inputSwitch(
                                              name: "Auto calculación:",
                                              context: context,
                                              value: autoCalculationVPM,
                                              activeColor: Colors.white,
                                              onChanged: (p0) => setState(() =>
                                                  autoCalculationVPM = p0),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FormWidgets
                                              .textFormFieldResizable(
                                            name: "SGL/DBL",
                                            isDecimal: true,
                                            isNumeric: true,
                                            isMoneda: true,
                                            controller: adults1_2VPMController,
                                            onChanged: (p0) {
                                              if (autoCalculationVPM) {
                                                adults3VPMController.text =
                                                    Utility.calculateRate(
                                                        adults1_2VPMController,
                                                        paxAdicVPMController,
                                                        1);
                                                adults4VPMController.text =
                                                    Utility.calculateRate(
                                                        adults1_2VPMController,
                                                        paxAdicVPMController,
                                                        2);
                                              }
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: FormWidgets
                                              .textFormFieldResizable(
                                            name: "PAX ADIC",
                                            isDecimal: true,
                                            isNumeric: true,
                                            isMoneda: true,
                                            controller: paxAdicVPMController,
                                            onChanged: (p0) {
                                              if (autoCalculationVPM) {
                                                adults3VPMController.text =
                                                    Utility.calculateRate(
                                                        adults1_2VPMController,
                                                        paxAdicVPMController,
                                                        1);
                                                adults4VPMController.text =
                                                    Utility.calculateRate(
                                                        adults1_2VPMController,
                                                        paxAdicVPMController,
                                                        2);
                                              }
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Opacity(
                                      opacity: autoCalculationVPM ? 0.5 : 1,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: FormWidgets
                                                .textFormFieldResizable(
                                              name: "TPL",
                                              isDecimal: true,
                                              isNumeric: true,
                                              isMoneda: true,
                                              blocked: autoCalculationVPM,
                                              controller: adults3VPMController,
                                              onChanged: (p0) {
                                                if (!autoCalculationVPM) {
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: FormWidgets
                                                .textFormFieldResizable(
                                              name: "CPLE",
                                              isDecimal: true,
                                              isNumeric: true,
                                              isMoneda: true,
                                              blocked: autoCalculationVPM,
                                              controller: adults4VPMController,
                                              onChanged: (p0) {
                                                if (!autoCalculationVPM) {
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FormWidgets
                                              .textFormFieldResizable(
                                            name: "MENORES 7 A 12 AÑOS",
                                            isDecimal: true,
                                            isNumeric: true,
                                            isMoneda: true,
                                            controller: minors7_12VPMController,
                                            onChanged: (p0) => setState(() {}),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: FormWidgets
                                              .textFormFieldResizable(
                                            name: "MENORES 0 A 6 AÑOS",
                                            isDecimal: true,
                                            initialValue: "GRATIS",
                                            isNumeric: true,
                                            // isMoneda: true,
                                            blocked: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    CustomWidgets.expansionTileCustomTarifa(
                                      colorTarifa: colorTarifa,
                                      nameTile: "Promoción",
                                      context: context,
                                      promocionController: promocionController,
                                      estanciaController:
                                          estanciaPromController,
                                      adults1_2Controller:
                                          adults1_2VPMController,
                                      paxAdicController: paxAdicVPMController,
                                      adults3Controller: adults3VPMController,
                                      adults4Controller: adults4VPMController,
                                      minors7_12Controller:
                                          minors7_12VPMController,
                                      onChanged: (p0) {
                                        bar1Controller.text =
                                            (Utility.parseDoubleText(p0) + 1)
                                                .toString();
                                        bar2Controller.text =
                                            (Utility.parseDoubleText(p0) + 2)
                                                .toString();
                                        setState(() {});
                                      },
                                    ),
                                    CustomWidgets.expansionTileCustomTarifa(
                                      colorTarifa: colorTarifa,
                                      nameTile: "BAR I",
                                      context: context,
                                      promocionController: bar1Controller,
                                      estanciaController:
                                          estanciaBar1Controller,
                                      adults1_2Controller:
                                          adults1_2VPMController,
                                      paxAdicController: paxAdicVPMController,
                                      adults3Controller: adults3VPMController,
                                      adults4Controller: adults4VPMController,
                                      minors7_12Controller:
                                          minors7_12VPMController,
                                    ),
                                    CustomWidgets.expansionTileCustomTarifa(
                                      colorTarifa: colorTarifa,
                                      nameTile: "BAR II",
                                      context: context,
                                      promocionController: bar2Controller,
                                      estanciaController:
                                          estanciaBar2Controller,
                                      adults1_2Controller:
                                          adults1_2VPMController,
                                      paxAdicController: paxAdicVPMController,
                                      adults3Controller: adults3VPMController,
                                      adults4Controller: adults4VPMController,
                                      minors7_12Controller:
                                          minors7_12VPMController,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 35,
                            width: 130,
                            child: Buttons.commonButton(
                              onPressed: () async {
                                await savedTariff();
                              },
                              sizeText: 15,
                              text: "Guardar",
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate(target: target).fadeIn();
  }

  bool evaluatedDates(
      List<Periodo> periodos, String fechaIni, String fechaSal) {
    bool isRepeat = false;

    isRepeat = periodos.any((element) =>
        (element.fechaInicial!.compareTo(DateTime.parse(fechaIni)) >= 0 &&
            element.fechaFinal!.compareTo(DateTime.parse(fechaSal)) <= 0) ||
        element.fechaFinal!.compareTo(DateTime.parse(fechaIni)) >= 0);

    return isRepeat;
  }

  double getWidthResizableTemporada(double screenWidth) {
    return screenWidth > 800
        ? ((screenWidth - 32) - (widget.sideController.extended ? 230 : 122)) *
            0.327
        : screenWidth > 700
            ? ((screenWidth - 32)) * 0.3125
            : (screenWidth - 32) * 0.47;
  }

  double getWidthResizableTarifa(double screenWidth) {
    return screenWidth > 800
        ? ((screenWidth - 37) - (widget.sideController.extended ? 230 : 122)) *
            0.499
        : screenWidth > 650
            ? ((screenWidth - 32)) * 0.47
            : screenWidth;
  }

  WrapAlignment getWrapAligmentContainer(double screenWidth) {
    return (getWidthResizableTarifa(screenWidth) > 320)
        ? WrapAlignment.spaceBetween
        : WrapAlignment.center;
  }

  Future<void> savedTariff() async {
    if (!_formKeyTarifa.currentState!.validate()) return;

    if (periodos.isEmpty) {
      showSnackBar(
        context: context,
        title: "Periodo(s) requeridos",
        message:
            "Se requiere al menos un periodo para aplicar esta tarifa en el calendario",
        type: "danger",
      );
      return;
    }

    TarifaTemporada tarifaVR = TarifaTemporada(
        categoria: "VISTA RESERVA",
        tarifaAdulto1a2: double.parse(adults1_2VRController.text),
        tarifaAdulto3: double.parse(adults3VRController.text),
        tarifaAdulto4: double.parse(adults4VRController.text),
        tarifaMenores7a12: double.parse(minors7_12VRController.text),
        tarifaPaxAdicional: double.parse(paxAdicVRController.text));
    TarifaTemporada tarifaVPM = TarifaTemporada(
        categoria: "VISTA PARCIAL AL MAR",
        tarifaAdulto1a2: double.parse(adults1_2VPMController.text),
        tarifaAdulto3: double.parse(adults3VPMController.text),
        tarifaAdulto4: double.parse(adults4VPMController.text),
        tarifaMenores7a12: double.parse(minors7_12VPMController.text),
        tarifaPaxAdicional: double.parse(paxAdicVPMController.text));
    Temporada temporadaPromocion = Temporada(
        estanciaMinima: int.parse(estanciaPromController.text),
        porcentajePromocion: double.parse(promocionController.text));
    Temporada temporadaBar1 = Temporada(
        estanciaMinima: int.parse(estanciaBar1Controller.text),
        porcentajePromocion: double.parse(bar1Controller.text));
    Temporada temporadaBar2 = Temporada(
        estanciaMinima: int.parse(estanciaBar2Controller.text),
        porcentajePromocion: double.parse(bar2Controller.text));

    bool isSaves = await TarifaService().saveTarifaBD(
      name: nombreTarifaController.text,
      colorIdentificativo: colorTarifa,
      diasAplicacion: selectedDayWeek,
      periodos: periodos,
      tempProm: temporadaPromocion,
      tempBar1: temporadaBar1,
      tempBar2: temporadaBar2,
      tarifaVPM: tarifaVPM,
      tarifaVR: tarifaVR,
    );

    if (isSaves) {
      showSnackBar(
          context: context,
          title: "Tarifa implementada",
          message: "La tarifa fue guardada e implementada con exito",
          type: "success");
      setState(() => target = 0);

      Future.delayed(
        500.ms,
        () {
          ref
              .read(changeTarifasProvider.notifier)
              .update((state) => UniqueKey().hashCode);
        },
      );

      Future.delayed(650.ms, () => widget.sideController.selectIndex(5));
    } else {
      if (mounted) return;
      showSnackBar(
          context: context,
          title: "Error de guardado",
          message: "Se detecto un error al intentar guardar la tarifa.",
          type: "danger");
      return;
    }
  }
}
