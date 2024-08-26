import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/item_row.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../../ui/custom_widgets.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/text_styles.dart';
import '../../widgets/textformfield_custom.dart';

class FormTarifarioView extends StatefulWidget {
  const FormTarifarioView({Key? key, required this.sideController})
      : super(key: key);

  final SidebarXController sideController;

  @override
  State<FormTarifarioView> createState() => _FormTarifarioViewState();
}

class _FormTarifarioViewState extends State<FormTarifarioView> {
  String type = tipoHabitacion.first;
  String plan = planes.first;
  bool inAllPeriod = false;
  double target = 1;
  Color colorTarifa = Colors.amber;
  TextEditingController _fechaEntrada = TextEditingController(text: "");
  TextEditingController _fechaSalida = TextEditingController(text: "");
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

  List<PeriodoData> periodos = [];

  final List<bool> selectedModeCalendar = <bool>[
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
    _fechaEntrada.dispose();
    _fechaSalida.dispose();
    promocionController.dispose();
    adults1_2VRController.dispose();
    adults3VRController.dispose();
    adults4VRController.dispose();
    paxAdicVRController.dispose();
    minors7_12VRController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() => target = 0);

                      Future.delayed(
                          500.ms, () => widget.sideController.selectIndex(5));
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
                                            name: "Nombre de la tarifa Rack"),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: FormWidgets.inputColor(
                                      nameInput: "Color:",
                                      primaryColor: colorTarifa,
                                      colorText: Theme.of(context).primaryColor,
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
                                        listModes: selectedModeCalendar,
                                        modesVisual: [],
                                        onChanged: (p0, p1) {},
                                        isReactive: false,
                                        isCompact: true,
                                        arrayStrings: daysNameShort,
                                        borderRadius: 12,
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
                                      selectedModeCalendar.clear();
                                      selectedModeCalendar.addAll([
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
                                        _fechaSalida.text = Utility.getNextDay(
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
                                  if (!evaluatedDates(periodos,
                                      _fechaEntrada.text, _fechaSalida.text)) {
                                    periodos.add(
                                      PeriodoData(
                                        id: 0,
                                        code: "",
                                        fechaInicial:
                                            DateTime.parse(_fechaEntrada.text),
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
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
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
                          text: "Tarífas",
                          size: 18,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        runSpacing: 15,
                        spacing: 15,
                        children: [
                          SizedBox(
                            width: screenWidth > 800
                                ? ((screenWidth - 37) -
                                        (widget.sideController.extended
                                            ? 230
                                            : 122)) *
                                    0.499
                                : screenWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: DesktopColors.vistaReserva,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(7))),
                                  child: Center(
                                    child: TextStyles.mediumText(
                                      text: "VISTA RESERVA",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FormWidgets.textFormFieldResizable(
                                        name: "SGL/DBL",
                                        isDecimal: true,
                                        isNumeric: true,
                                        isMoneda: true,
                                        controller: adults1_2VRController,
                                        onChanged: (p0) {
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
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: FormWidgets.textFormFieldResizable(
                                        name: "PAX ADIC",
                                        isDecimal: true,
                                        isNumeric: true,
                                        isMoneda: true,
                                        controller: paxAdicVRController,
                                        onChanged: (p0) {
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
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Opacity(
                                  opacity: 0.5,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child:
                                            FormWidgets.textFormFieldResizable(
                                          name: "TPL",
                                          isDecimal: true,
                                          isNumeric: true,
                                          isMoneda: true,
                                          blocked: true,
                                          controller: adults3VRController,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child:
                                            FormWidgets.textFormFieldResizable(
                                          name: "CPLE",
                                          isDecimal: true,
                                          isNumeric: true,
                                          isMoneda: true,
                                          blocked: true,
                                          controller: adults4VRController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FormWidgets.textFormFieldResizable(
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
                                      child: FormWidgets.textFormFieldResizable(
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
                                  estanciaController: estanciaPromController,
                                  adults1_2Controller: adults1_2VRController,
                                  paxAdicController: paxAdicVRController,
                                  adults3Controller: adults3VRController,
                                  adults4Controller: adults4VRController,
                                  minors7_12Controller: minors7_12VRController,
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
                                  estanciaController: estanciaBar1Controller,
                                  adults1_2Controller: adults1_2VRController,
                                  paxAdicController: paxAdicVRController,
                                  adults3Controller: adults3VRController,
                                  adults4Controller: adults4VRController,
                                  minors7_12Controller: minors7_12VRController,
                                ),
                                CustomWidgets.expansionTileCustomTarifa(
                                  colorTarifa: colorTarifa,
                                  nameTile: "BAR II",
                                  context: context,
                                  promocionController: bar2Controller,
                                  estanciaController: estanciaBar2Controller,
                                  adults1_2Controller: adults1_2VRController,
                                  paxAdicController: paxAdicVRController,
                                  adults3Controller: adults3VRController,
                                  adults4Controller: adults4VRController,
                                  minors7_12Controller: minors7_12VRController,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenWidth > 800
                                ? ((screenWidth - 37) -
                                        (widget.sideController.extended
                                            ? 230
                                            : 122)) *
                                    0.499
                                : screenWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: DesktopColors.vistaParcialMar,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(7))),
                                  child: Center(
                                    child: TextStyles.mediumText(
                                      text: "VISTA PARCIAL AL MAR",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FormWidgets.textFormFieldResizable(
                                        name: "SGL/DBL",
                                        isDecimal: true,
                                        isNumeric: true,
                                        isMoneda: true,
                                        controller: adults1_2VPMController,
                                        onChanged: (p0) {
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
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: FormWidgets.textFormFieldResizable(
                                        name: "PAX ADIC",
                                        isDecimal: true,
                                        isNumeric: true,
                                        isMoneda: true,
                                        controller: paxAdicVPMController,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Opacity(
                                  opacity: 0.5,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child:
                                            FormWidgets.textFormFieldResizable(
                                          name: "TPL",
                                          isDecimal: true,
                                          isNumeric: true,
                                          isMoneda: true,
                                          blocked: true,
                                          controller: adults3VPMController,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child:
                                            FormWidgets.textFormFieldResizable(
                                          name: "CPLE",
                                          isDecimal: true,
                                          isNumeric: true,
                                          isMoneda: true,
                                          blocked: true,
                                          controller: adults4VPMController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FormWidgets.textFormFieldResizable(
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
                                      child: FormWidgets.textFormFieldResizable(
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate(target: target).fadeIn();
  }

  bool evaluatedDates(
      List<PeriodoData> periodos, String fechaIni, String fechaSal) {
    bool isRepeat = false;

    isRepeat = periodos.any((element) =>
        element.fechaInicial!.compareTo(DateTime.parse(fechaIni)) >= 0 &&
        element.fechaFinal!.compareTo(DateTime.parse(fechaSal)) <= 0);

    return isRepeat;
  }
}
