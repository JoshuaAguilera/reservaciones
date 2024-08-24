import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/widgets/item_row.dart';

import '../../ui/custom_widgets.dart';
import '../../utils/helpers/constants.dart';
import '../../utils/helpers/utility.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/form_widgets.dart';
import '../../widgets/text_styles.dart';
import '../../widgets/textformfield_custom.dart';

class FormTarifarioView extends StatefulWidget {
  const FormTarifarioView(
      {Key? key, required this.target, required this.onTarget})
      : super(key: key);

  final bool target;
  final void Function()? onTarget;

  @override
  State<FormTarifarioView> createState() => _FormTarifarioViewState();
}

class _FormTarifarioViewState extends State<FormTarifarioView> {
  String type = tipoHabitacion.first;
  String plan = planes.first;
  bool inAllPeriod = false;
  Color colorTarifa = Colors.amber;
  TextEditingController _fechaEntrada = TextEditingController(text: "");
  TextEditingController _fechaSalida = TextEditingController(text: "");
  TextEditingController _promocionController = TextEditingController();
  TextEditingController _adults1_2Controller = TextEditingController();
  TextEditingController _adults3Controller = TextEditingController(text: "0");
  TextEditingController _adults4Controller = TextEditingController(text: "0");
  TextEditingController _paxAdicController = TextEditingController();
  TextEditingController _minors7_12Controller = TextEditingController();
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
    _promocionController.dispose();
    _adults1_2Controller.dispose();
    _adults3Controller.dispose();
    _adults4Controller.dispose();
    _paxAdicController.dispose();
    _minors7_12Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: 550,
      height: screenHeight - 165,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextStyles.standardText(
                        text: "Crear tarifa",
                        isBold: true,
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Buttons.commonButton(
                            onPressed: () {}, text: "Guardar", isBold: true),
                        const SizedBox(width: 15),
                        IconButton(
                          onPressed: () => widget.onTarget!.call(),
                          icon: const Icon(CupertinoIcons.clear),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextStyles.titleText(
                    text: "Datos generales",
                    size: 15,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormFieldCustom.textFormFieldwithBorder(
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 10),
                  child: AbsorbPointer(
                    absorbing: inAllPeriod,
                    child: Opacity(
                      opacity: inAllPeriod ? 0.5 : 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextStyles.standardText(
                              text: "Dias de aplicación:",
                              color: Theme.of(context).primaryColor),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: FormWidgets.inputSwitch(
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
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 5),
                  child: TextStyles.titleText(
                    text: "Periodos",
                    size: 15,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child:
                          TextFormFieldCustom.textFormFieldwithBorderCalendar(
                        name: "Fecha de entrada",
                        msgError: "Campo requerido*",
                        fechaLimite: DateTime(DateTime.now().year, 1, 1)
                            .subtract(const Duration(days: 1))
                            .toIso8601String(),
                        dateController: _fechaEntrada,
                        onChanged: () => setState(
                          () {
                            if (DateTime.parse(_fechaSalida.text)
                                .isBefore(DateTime.parse(_fechaEntrada.text))) {
                              _fechaSalida.text =
                                  Utility.getNextDay(_fechaEntrada.text);
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child:
                          TextFormFieldCustom.textFormFieldwithBorderCalendar(
                        name: "Fecha de salida",
                        msgError: "Campo requerido*",
                        dateController: _fechaSalida,
                        fechaLimite: DateTime.parse(_fechaEntrada.text)
                            .subtract(const Duration(days: 1))
                            .toIso8601String(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (!evaluatedDates(
                            periodos, _fechaEntrada.text, _fechaSalida.text)) {
                          periodos.add(
                            PeriodoData(
                              id: 0,
                              code: "",
                              fechaInicial: DateTime.parse(_fechaEntrada.text),
                              fechaFinal: DateTime.parse(_fechaSalida.text),
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
                        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
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
                const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextStyles.titleText(
                    text: "Tarífas",
                    size: 15,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 375,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: TextStyles.standardText(
                                  text: "Categoría: ",
                                  overClip: true,
                                  color: Theme.of(context).primaryColor)),
                          const SizedBox(width: 5),
                          CustomDropdown.dropdownMenuCustom(
                            initialSelection: type,
                            onSelected: (String? value) {
                              type = value!;
                            },
                            elements: tipoHabitacion,
                            screenWidth: 600,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Promoción",
                        isNumeric: true,
                        icon: const Icon(CupertinoIcons.percent),
                        controller: _promocionController,
                        onChanged: (p0) => setState(() {}),
                      ),
                    ),
                  ],
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
                        controller: _adults1_2Controller,
                        onChanged: (p0) {
                          _adults3Controller.text = Utility.calculateRate(
                              _adults1_2Controller, _paxAdicController, 1);
                          _adults4Controller.text = Utility.calculateRate(
                              _adults1_2Controller, _paxAdicController, 2);
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
                        controller: _paxAdicController,
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
                        child: FormWidgets.textFormFieldResizable(
                          name: "TPL",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          blocked: true,
                          controller: _adults3Controller,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "CPLE",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          blocked: true,
                          controller: _adults4Controller,
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
                        controller: _minors7_12Controller,
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
                const SizedBox(height: 10),
                ExpansionTile(
                  initiallyExpanded: true,
                  shape: Border(top: BorderSide(color: colorTarifa)),
                  collapsedShape: Border(top: BorderSide(color: colorTarifa)),
                  title: TextStyles.standardText(
                    text: "Promoción",
                    isBold: true,
                    color: Theme.of(context).primaryColor,
                    size: 14,
                  ),
                  children: [
                    const SizedBox(height: 15),
                    Opacity(
                      opacity: 0.5,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "SGL/DBL",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              controller: TextEditingController(
                                  text: Utility.calculatePromotion(
                                      _adults1_2Controller,
                                      _promocionController,
                                      0)),
                              blocked: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "PAX ADIC",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              controller: TextEditingController(
                                  text: Utility.calculatePromotion(
                                      _paxAdicController,
                                      _promocionController,
                                      0)),
                              blocked: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Opacity(
                      opacity: 0.5,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "TPL",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              blocked: true,
                              controller: TextEditingController(
                                text: Utility.calculatePromotion(
                                  _adults3Controller,
                                  _promocionController,
                                  0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "CPLE",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              blocked: true,
                              controller: TextEditingController(
                                text: Utility.calculatePromotion(
                                  _adults4Controller,
                                  _promocionController,
                                  0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Opacity(
                      opacity: 0.5,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "MENORES 7 A 12 AÑOS",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              blocked: true,
                              controller: TextEditingController(
                                text: Utility.calculatePromotion(
                                  _minors7_12Controller,
                                  _promocionController,
                                  0,
                                ),
                              ),
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
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ExpansionTile(
                  initiallyExpanded: true,
                  shape: Border(top: BorderSide(color: colorTarifa)),
                  collapsedShape: Border(top: BorderSide(color: colorTarifa)),
                  title: TextStyles.standardText(
                    text: "BAR I",
                    isBold: true,
                    color: Theme.of(context).primaryColor,
                    size: 14,
                  ),
                  children: [
                    const SizedBox(height: 15),
                    Opacity(
                      opacity: 0.5,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "SGL/DBL",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              controller: TextEditingController(
                                  text: Utility.calculatePromotion(
                                      _adults1_2Controller,
                                      _promocionController,
                                      1)),
                              blocked: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "PAX ADIC",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              controller: TextEditingController(
                                  text: Utility.calculatePromotion(
                                      _paxAdicController,
                                      _promocionController,
                                      1)),
                              blocked: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Opacity(
                      opacity: 0.5,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "TPL",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              blocked: true,
                              controller: TextEditingController(
                                text: Utility.calculatePromotion(
                                  _adults3Controller,
                                  _promocionController,
                                  1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "CPLE",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              blocked: true,
                              controller: TextEditingController(
                                text: Utility.calculatePromotion(
                                  _adults4Controller,
                                  _promocionController,
                                  1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Opacity(
                      opacity: 0.5,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "MENORES 7 A 12 AÑOS",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              blocked: true,
                              controller: TextEditingController(
                                text: Utility.calculatePromotion(
                                  _minors7_12Controller,
                                  _promocionController,
                                  1,
                                ),
                              ),
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
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ExpansionTile(
                  initiallyExpanded: true,
                  shape: Border(top: BorderSide(color: colorTarifa)),
                  collapsedShape: Border(top: BorderSide(color: colorTarifa)),
                  title: TextStyles.standardText(
                    text: "BAR II",
                    isBold: true,
                    color: Theme.of(context).primaryColor,
                    size: 14,
                  ),
                  children: [
                    const SizedBox(height: 15),
                    Opacity(
                      opacity: 0.5,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "SGL/DBL",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              controller: TextEditingController(
                                  text: Utility.calculatePromotion(
                                      _adults1_2Controller,
                                      _promocionController,
                                      2)),
                              blocked: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "PAX ADIC",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              controller: TextEditingController(
                                  text: Utility.calculatePromotion(
                                      _paxAdicController,
                                      _promocionController,
                                      2)),
                              blocked: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Opacity(
                      opacity: 0.5,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "TPL",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              blocked: true,
                              controller: TextEditingController(
                                text: Utility.calculatePromotion(
                                  _adults3Controller,
                                  _promocionController,
                                  2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "CPLE",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              blocked: true,
                              controller: TextEditingController(
                                text: Utility.calculatePromotion(
                                  _adults4Controller,
                                  _promocionController,
                                  2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Opacity(
                      opacity: 0.5,
                      child: Row(
                        children: [
                          Expanded(
                            child: FormWidgets.textFormFieldResizable(
                              name: "MENORES 7 A 12 AÑOS",
                              isDecimal: true,
                              isNumeric: true,
                              isMoneda: true,
                              blocked: true,
                              controller: TextEditingController(
                                text: Utility.calculatePromotion(
                                  _minors7_12Controller,
                                  _promocionController,
                                  2,
                                ),
                              ),
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate(target: !widget.target ? 1 : 0)
        .slideX(begin: 0.2, duration: 550.ms)
        .fadeIn();
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
