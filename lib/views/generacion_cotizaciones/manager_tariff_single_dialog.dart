import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/ui/buttons.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/widgets/form_tariff_widget.dart';

import '../../providers/habitacion_provider.dart';
import '../../ui/custom_widgets.dart';
import '../../utils/helpers/utility.dart';
import '../../utils/helpers/web_colors.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/text_styles.dart';
import '../../widgets/textformfield_custom.dart';

class ManagerTariffSingleDialog extends ConsumerStatefulWidget {
  const ManagerTariffSingleDialog(
      {super.key,
      required this.tarifaXDia,
      this.isAppling = false,
      required this.numDays});

  final TarifaXDia tarifaXDia;
  final bool isAppling;
  final int numDays;

  @override
  _ManagerTariffDayWidgetState createState() => _ManagerTariffDayWidgetState();
}

class _ManagerTariffDayWidgetState
    extends ConsumerState<ManagerTariffSingleDialog> {
  String temporadaSelect = "Mayo - Abril";
  bool applyAllTariff = false;
  bool applyAllDays = false;
  bool applyAllNoTariff = false;
  bool applyAllCategory = false;
  bool isUnknow = false;
  bool isFreeTariff = false;
  bool showErrorTariff = false;
  final _formKeyTariffDay = GlobalKey<FormState>();
  List<String> categorias = ["VISTA A LA RESERVA", "VISTA PARCIAL AL MAR"];
  String selectCategory = "VISTA A LA RESERVA";
  TarifaData? saveTariff;
  bool startFlow = false;

  List<String> promociones = [];
  final TextEditingController _tarifaAdultoController =
      TextEditingController(text: "");
  final TextEditingController _tarifaAdultoTPLController =
      TextEditingController(text: "");
  final TextEditingController _tarifaAdultoCPLController =
      TextEditingController(text: "");
  final TextEditingController _tarifaMenoresController =
      TextEditingController(text: "");
  final TextEditingController _tarifaPaxAdicionalController =
      TextEditingController(text: "");
  final TextEditingController _descuentoController = TextEditingController();

  @override
  void initState() {
    _descuentoController.text =
        (widget.tarifaXDia.descuentoProvisional ?? 0).toString();
    isUnknow = widget.tarifaXDia.code!.contains("Unknow");
    isFreeTariff = widget.tarifaXDia.code!.contains("tariffFree");
    temporadaSelect = widget.tarifaXDia.temporadaSelect?.nombre ?? 'No aplicar';
    promociones.add("No aplicar");

    if (widget.tarifaXDia.tarifa != null) {
      _tarifaAdultoController.text =
          widget.tarifaXDia.tarifa!.tarifaAdultoSGLoDBL!.toString();
      _tarifaAdultoTPLController.text =
          widget.tarifaXDia.tarifa!.tarifaAdultoTPL!.toString();
      _tarifaAdultoCPLController.text =
          widget.tarifaXDia.tarifa!.tarifaAdultoCPLE!.toString();
      _tarifaMenoresController.text =
          widget.tarifaXDia.tarifa!.tarifaMenores7a12!.toString();
      _tarifaPaxAdicionalController.text =
          widget.tarifaXDia.tarifa!.tarifaPaxAdicional.toString();

      selectCategory = categorias[
          tipoHabitacion.indexOf(widget.tarifaXDia.tarifa!.categoria!)];
    }

    if (widget.tarifaXDia.tarifa != null) {
      TarifaData? detectTarifa =
          (widget.tarifaXDia.tarifas ?? List<TarifaData>.empty())
              .where((element) =>
                  element.categoria != widget.tarifaXDia.tarifa!.categoria)
              .toList()
              .firstOrNull;
      if (detectTarifa != null) saveTariff = detectTarifa.copyWith();
    }

    // promociones += Utility.getSeasonstoString(widget.tarifaXDia.temporadas);
    super.initState();
  }

  @override
  void dispose() {
    _tarifaAdultoController.dispose();
    _tarifaAdultoTPLController.dispose();
    _tarifaAdultoCPLController.dispose();
    _tarifaMenoresController.dispose();
    _tarifaPaxAdicionalController.dispose();
    _descuentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final habitacionProvider = ref.watch(habitacionSelectProvider);
    double tariffAdult = calculateTariffAdult(habitacionProvider.adultos!);
    double tariffChildren =
        calculateTariffMenor(habitacionProvider.menores7a12!);
    final typeQuote = ref.watch(typeQuoteProvider);

    if (!startFlow && widget.tarifaXDia.tarifa == null) {
      selectCategory =
          categorias[tipoHabitacion.indexOf(habitacionProvider.categoria!)];
      startFlow = true;
    }

    return AlertDialog(
      elevation: 15,
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            color: widget.tarifaXDia.color ?? DesktopColors.ceruleanOscure,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                CupertinoIcons.pencil_outline,
                size: 33,
                color: useWhiteForeground(
                        widget.tarifaXDia.color ?? DesktopColors.ceruleanOscure)
                    ? Colors.white
                    : const Color.fromARGB(255, 43, 43, 43),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextStyles.titleText(
                text: widget.isAppling
                    ? "Aplicar nueva Tarifa ${typeQuote ? "Grupal " : ""}libre \n${Utility.getPeriodReservation([
                            habitacionProvider
                          ])}"
                    : "Modificar tarifa del ${Utility.getCompleteDate(data: widget.tarifaXDia.fecha)} \nTarifa aplicada: ${widget.tarifaXDia.nombreTariff} ${widget.tarifaXDia.subCode != null ? "(modificada)" : ""}",
                size:
                    (widget.tarifaXDia.subCode != null && !isUnknow) ? 13 : 16,
                color: Theme.of(context).primaryColor),
          ),
        ],
      ),
      content: SizedBox(
        height: 625,
        child: Form(
          key: _formKeyTariffDay,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      (widget.tarifaXDia.temporadaSelect != null ||
                              widget.tarifaXDia.temporadas != null)
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                  children: [
                    TextStyles.standardText(
                      text: widget.tarifaXDia.temporadaSelect != null
                          ? "Temporada: "
                          : "Descuento en toda la tarifa:         ",
                      overClip: true,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10),
                    if (widget.tarifaXDia.temporadas != null &&
                        widget.tarifaXDia.temporadas!.isNotEmpty)
                      CustomDropdown.dropdownMenuCustom(
                        initialSelection: temporadaSelect,
                        onSelected: (String? value) =>
                            setState(() => temporadaSelect = value!),
                        elements: promociones +
                            Utility.getSeasonstoString(
                                widget.tarifaXDia.temporadas,
                                onlyGroups: typeQuote),
                        excepcionItem: "No aplicar",
                        notElements: Utility.getPromocionesNoValidas(
                          habitacionProvider,
                          temporadas: widget.tarifaXDia.temporadas,
                        ),
                      )
                    else
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextFormFieldCustom.textFormFieldwithBorder(
                            name: "Porcentaje",
                            controller: _descuentoController,
                            icon: const Icon(CupertinoIcons.percent, size: 20),
                            isNumeric: true,
                            onChanged: (p0) => setState(() {}),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 15),
                AbsorbPointer(
                  absorbing: applyAllCategory,
                  child: Opacity(
                    opacity: applyAllCategory ? 0.5 : 1,
                    child: SizedBox(
                      height: 32,
                      width: 350,
                      child: StatefulBuilder(
                        builder: (context, snapshot) {
                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: 2,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: SelectableButton(
                                  selected: selectCategory == categorias[index],
                                  color: Utility.darken(
                                      selectCategory == categorias.first
                                          ? DesktopColors.vistaReserva
                                          : DesktopColors.vistaParcialMar,
                                      -0.15),
                                  onPressed: () {
                                    if (selectCategory == categorias[index])
                                      return;

                                    TarifaData? selectTariff = (isFreeTariff ||
                                            isUnknow)
                                        ? null
                                        : widget.tarifaXDia.tarifas
                                            ?.firstWhere(
                                              (element) =>
                                                  element.categoria ==
                                                  tipoHabitacion[categorias
                                                      .indexOf(selectCategory)],
                                            )
                                            .copyWith();

                                    TarifaData saveIntTariff = TarifaData(
                                      categoria: tipoHabitacion[
                                          categorias.indexOf(selectCategory)],
                                      code: selectTariff?.code ??
                                          "${widget.tarifaXDia.code} - $selectCategory",
                                      fecha:
                                          selectTariff?.fecha ?? DateTime.now(),
                                      id: selectTariff?.id ??
                                          categorias.indexOf(selectCategory),
                                      tarifaAdultoSGLoDBL:
                                          _tarifaAdultoController.text.isEmpty
                                              ? selectTariff
                                                  ?.tarifaAdultoSGLoDBL
                                              : double.parse(
                                                  _tarifaAdultoController.text),
                                      tarifaAdultoTPL:
                                          _tarifaAdultoTPLController
                                                  .text.isEmpty
                                              ? selectTariff?.tarifaAdultoTPL
                                              : double.parse(
                                                  _tarifaAdultoTPLController
                                                      .text),
                                      tarifaAdultoCPLE:
                                          _tarifaAdultoCPLController
                                                  .text.isEmpty
                                              ? selectTariff?.tarifaAdultoCPLE
                                              : double.parse(
                                                  _tarifaAdultoCPLController
                                                      .text),
                                      tarifaPaxAdicional:
                                          _tarifaPaxAdicionalController
                                                  .text.isEmpty
                                              ? selectTariff?.tarifaPaxAdicional
                                              : double.parse(
                                                  _tarifaPaxAdicionalController
                                                      .text),
                                      tarifaMenores7a12:
                                          _tarifaMenoresController.text.isEmpty
                                              ? selectTariff?.tarifaMenores7a12
                                              : double.parse(
                                                  _tarifaMenoresController
                                                      .text),
                                    );

                                    _tarifaAdultoController.text =
                                        (saveTariff?.tarifaAdultoSGLoDBL ?? '')
                                            .toString();
                                    _tarifaAdultoTPLController.text =
                                        (saveTariff?.tarifaAdultoTPL ?? '')
                                            .toString();
                                    _tarifaAdultoCPLController.text =
                                        (saveTariff?.tarifaAdultoCPLE ?? '')
                                            .toString();
                                    _tarifaPaxAdicionalController.text =
                                        (saveTariff?.tarifaPaxAdicional ?? '')
                                            .toString();
                                    _tarifaMenoresController.text =
                                        (saveTariff?.tarifaMenores7a12 ?? '')
                                            .toString();

                                    saveTariff = saveIntTariff.copyWith();
                                    showErrorTariff = false;

                                    setState(() =>
                                        selectCategory = categorias[index]);
                                  },
                                  child: Text(
                                    categorias[index],
                                    style: TextStyle(
                                      color: Utility.darken(
                                        selectCategory == categorias.first
                                            ? DesktopColors.vistaReserva
                                            : DesktopColors.vistaParcialMar,
                                        0.15,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      FormTariffWidget(
                        tarifaAdultoController: _tarifaAdultoController,
                        tarifaAdultoTPLController: _tarifaAdultoTPLController,
                        tarifaAdultoCPLController: _tarifaAdultoCPLController,
                        tarifaPaxAdicionalController:
                            _tarifaPaxAdicionalController,
                        tarifaMenoresController: _tarifaMenoresController,
                        onUpdate: () => setState(() {}),
                        isEditing: true,
                      ),
                      Divider(color: Theme.of(context).primaryColor),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (isValidForApplyNotTariff(
                                        habitacionProvider) &&
                                    !widget.isAppling &&
                                    !isFreeTariff &&
                                    widget.numDays > 1)
                                  CustomWidgets.checkBoxWithDescription(
                                    context,
                                    activeColor: widget.tarifaXDia.color,
                                    title: "Aplicar en dias sin tarifa",
                                    description:
                                        "(Esta opción aplicara los siguientes cambios en todos los dias que no esten en el margen de las tarifas definidas).",
                                    value: applyAllNoTariff,
                                    onChanged: (value) => setState(() {
                                      applyAllNoTariff = value!;
                                      applyAllTariff = false;
                                      applyAllDays = false;
                                    }),
                                  ),
                                if (!isUnknow &&
                                    !widget.isAppling &&
                                    !isFreeTariff &&
                                    widget.numDays > 1)
                                  CustomWidgets.checkBoxWithDescription(
                                    context,
                                    activeColor: widget.tarifaXDia.color,
                                    title: "Aplicar en toda la tarifa",
                                    description:
                                        "(Esta opción aplicara los siguientes cambios en todos los periodos de la tarifa actual: \"${widget.tarifaXDia.nombreTariff}${widget.tarifaXDia.subCode != null ? " [modificado]" : ""}\").",
                                    value: applyAllTariff,
                                    onChanged: (value) => setState(() {
                                      applyAllTariff = value!;
                                      applyAllNoTariff = false;
                                      applyAllDays = false;
                                    }),
                                  ),
                                if (habitacionProvider.tarifaXDia!
                                    .any((element) => element.code != 'Unknow'))
                                  if (!widget.isAppling && widget.numDays > 1)
                                    CustomWidgets.checkBoxWithDescription(
                                      context,
                                      activeColor: widget.tarifaXDia.color,
                                      title: "Aplicar en todos los dias",
                                      description: "",
                                      value: applyAllDays,
                                      onChanged: (value) => setState(() {
                                        applyAllDays = value!;
                                        applyAllTariff = false;
                                        applyAllNoTariff = false;
                                      }),
                                    ),
                                if (widget.isAppling || isUnknow)
                                  CustomWidgets.checkBoxWithDescription(
                                    context,
                                    activeColor: widget.tarifaXDia.color,
                                    title: "Aplicar en ambas categorias",
                                    description:
                                        "(Vista Reserva, Vista Parcial al mar)",
                                    value: applyAllCategory,
                                    onChanged: (value) => setState(() {
                                      applyAllCategory = value!;
                                      showErrorTariff = false;
                                    }),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          StatefulBuilder(builder: (context, snapshot) {
                            return SizedBox(
                              width: 225,
                              child: Column(
                                children: [
                                  CustomWidgets.itemListCount(
                                      nameItem:
                                          "Adultos x${habitacionProvider.adultos}:",
                                      count: tariffAdult,
                                      context: context,
                                      height: 40),
                                  CustomWidgets.itemListCount(
                                      nameItem:
                                          "Menores de 7 a 12 x${habitacionProvider.menores7a12}:",
                                      count: tariffChildren,
                                      context: context,
                                      height: 40),
                                  CustomWidgets.itemListCount(
                                      nameItem:
                                          "Menores de 0 a 6 x${habitacionProvider.menores0a6}:",
                                      count: 0,
                                      context: context,
                                      height: 40),
                                  Divider(
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(height: 5),
                                  CustomWidgets.itemListCount(
                                      nameItem: "Total:",
                                      count: tariffAdult + tariffChildren,
                                      context: context,
                                      height: 40),
                                  CustomWidgets.itemListCount(
                                      nameItem:
                                          "Descuento (${(getSeasonSelect() != null) ? getSeasonSelect()?.porcentajePromocion ?? 0 : _descuentoController.text}%):",
                                      count: -(calculateDiscount(
                                                  tariffAdult + tariffChildren))
                                              .round() +
                                          0.0,
                                      context: context,
                                      height: 40),
                                  Divider(
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(height: 5),
                                  CustomWidgets.itemListCount(
                                      nameItem: "Total del dia(s):",
                                      count: ((tariffChildren + tariffAdult) -
                                                  (calculateDiscount(
                                                      tariffAdult +
                                                          tariffChildren)))
                                              .round() +
                                          0.0,
                                      context: context,
                                      height: 40),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                if (showErrorTariff)
                  Center(
                    child: Card(
                      color: Colors.red[900],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextStyles.standardText(
                          text:
                              "Se detectaron uno o mas campos por capturar la categoria: ${categorias.firstWhere((element) => element != selectCategory)}*",
                          size: 10,
                          color: Colors.white,
                          aling: TextAlign.center,
                        ),
                      ),
                    ).animate().flip(delay: 100.ms),
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: TextStyles.buttonText(
              text: "CANCELAR", color: Theme.of(context).primaryColor),
        ),
        SizedBox(
          width: 100,
          child: Buttons.commonButton(
            text: "ACEPTAR",
            colorText: useWhiteForeground(
                    widget.tarifaXDia.color ?? DesktopColors.ceruleanOscure)
                ? Colors.white
                : const Color.fromARGB(255, 43, 43, 43),
            color: widget.tarifaXDia.color ?? DesktopColors.cerulean,
            onPressed: () {
              if (!_formKeyTariffDay.currentState!.validate()) return;

              bool withChanges = detectFixInChanges();

              if (!withChanges &&
                  widget.tarifaXDia.tarifa != null &&
                  !applyAllDays &&
                  !applyAllNoTariff &&
                  !applyAllDays &&
                  !applyAllTariff) {
                Navigator.pop(context);
                return;
              }

              if (applyAllTariff && widget.tarifaXDia.subCode == null) {
                Navigator.pop(context);
                return;
              }

              if (revisedPropiertiesSaveTariff() && !applyAllCategory) {
                setState(() => showErrorTariff = true);
                return;
              } else {
                setState(() => showErrorTariff = false);
              }

              TarifaData? newTarifa = widget.tarifaXDia.tarifa;

              if (widget.tarifaXDia.tarifa != null &&
                  saveTariff!.categoria ==
                      widget.tarifaXDia.tarifa!.categoria) {
                widget.tarifaXDia.tarifa = saveTariff;

                int indexFirstTariff = widget.tarifaXDia.tarifas!.indexWhere(
                    (element) => element.categoria == saveTariff!.categoria);

                if (indexFirstTariff != -1) {
                  widget.tarifaXDia.tarifas![indexFirstTariff] =
                      widget.tarifaXDia.tarifa!;
                }

                newTarifa = widget.tarifaXDia.tarifas!.firstWhere(
                    (element) => element.categoria != saveTariff!.categoria);

                TarifaData? secondTariff = TarifaData(
                  id: newTarifa.id,
                  code: newTarifa.code,
                  categoria: newTarifa.categoria,
                  fecha: newTarifa.fecha ?? DateTime.now(),
                  tarifaAdultoSGLoDBL:
                      double.parse(_tarifaAdultoController.text),
                  tarifaAdultoTPL:
                      double.parse(_tarifaAdultoTPLController.text),
                  tarifaAdultoCPLE:
                      double.parse(_tarifaAdultoCPLController.text),
                  tarifaMenores7a12:
                      double.parse(_tarifaMenoresController.text),
                  tarifaPaxAdicional:
                      double.parse(_tarifaPaxAdicionalController.text),
                );

                int indexSecondTariff = widget.tarifaXDia.tarifas!.indexWhere(
                    (element) => element.categoria == secondTariff.categoria);

                if (indexSecondTariff != -1) {
                  widget.tarifaXDia.tarifas![indexSecondTariff] = secondTariff;
                }
              } else if (widget.tarifaXDia.tarifa != null) {
                widget.tarifaXDia.tarifa = TarifaData(
                  id: newTarifa?.id ?? 0,
                  code: newTarifa?.code ?? widget.tarifaXDia.code ?? '',
                  categoria:
                      newTarifa?.categoria ?? widget.tarifaXDia.categoria,
                  fecha: newTarifa?.fecha ?? DateTime.now(),
                  tarifaAdultoSGLoDBL:
                      double.parse(_tarifaAdultoController.text),
                  tarifaAdultoTPL:
                      double.parse(_tarifaAdultoTPLController.text),
                  tarifaAdultoCPLE:
                      double.parse(_tarifaAdultoCPLController.text),
                  tarifaMenores7a12:
                      double.parse(_tarifaMenoresController.text),
                  tarifaPaxAdicional:
                      double.parse(_tarifaPaxAdicionalController.text),
                );

                int indexFirstTariff = widget.tarifaXDia.tarifas!.indexWhere(
                    (element) =>
                        element.categoria ==
                        widget.tarifaXDia.tarifa!.categoria);

                if (indexFirstTariff != -1) {
                  widget.tarifaXDia.tarifas![indexFirstTariff] =
                      widget.tarifaXDia.tarifa!;
                }

                int indexSecondTariff = widget.tarifaXDia.tarifas!.indexWhere(
                    (element) => element.categoria == saveTariff?.categoria);

                if (indexSecondTariff != -1) {
                  widget.tarifaXDia.tarifas![indexSecondTariff] = saveTariff!;
                }
              }

              if (widget.tarifaXDia.tarifa == null) {
                TarifaData newTariff = TarifaData(
                  id: newTarifa?.id ?? categorias.indexOf(selectCategory),
                  code: newTarifa?.code ?? '',
                  categoria: tipoHabitacion[categorias.indexOf(selectCategory)],
                  fecha: newTarifa?.fecha ?? DateTime.now(),
                  tarifaAdultoSGLoDBL:
                      double.parse(_tarifaAdultoController.text),
                  tarifaAdultoTPL:
                      double.parse(_tarifaAdultoTPLController.text),
                  tarifaAdultoCPLE:
                      double.parse(_tarifaAdultoCPLController.text),
                  tarifaMenores7a12:
                      double.parse(_tarifaMenoresController.text),
                  tarifaPaxAdicional:
                      double.parse(_tarifaPaxAdicionalController.text),
                );

                widget.tarifaXDia.tarifa = newTariff;

                if (applyAllCategory) saveTariff = newTarifa;

                TarifaData secondTariff = TarifaData(
                  id: categorias.indexOf(categorias
                      .firstWhere((element) => element != selectCategory)),
                  // code: saveTariff?.code ?? '',
                  code: '',
                  categoria: tipoHabitacion[categorias.indexOf(categorias
                      .firstWhere((element) => element != selectCategory))],
                  fecha: saveTariff?.fecha ?? DateTime.now(),
                  tarifaAdultoSGLoDBL: saveTariff?.tarifaAdultoSGLoDBL,
                  tarifaAdultoTPL: saveTariff?.tarifaAdultoTPL,
                  tarifaAdultoCPLE: saveTariff?.tarifaAdultoCPLE,
                  tarifaPaxAdicional: saveTariff?.tarifaPaxAdicional,
                  tarifaMenores7a12: saveTariff?.tarifaMenores7a12,
                );

                if (widget.tarifaXDia.tarifas == null) {
                  widget.tarifaXDia.tarifas = [newTariff, secondTariff];
                } else {
                  int indexSecondTariff = widget.tarifaXDia.tarifas!.indexWhere(
                      (element) => element.categoria == secondTariff.categoria);

                  if (indexSecondTariff != -1) {
                    widget.tarifaXDia.tarifas![indexSecondTariff] =
                        secondTariff;
                  } else {
                    widget.tarifaXDia.tarifas!.add(secondTariff);
                  }
                }
              }

              widget.tarifaXDia.temporadaSelect = getSeasonSelect();

              if (isUnknow || isFreeTariff) {
                widget.tarifaXDia.descuentoProvisional =
                    double.parse(_descuentoController.text);
              }

              if (applyAllTariff) {
                for (var element in habitacionProvider.tarifaXDia!) {
                  if (element.code == widget.tarifaXDia.code) {
                    element.tarifa = widget.tarifaXDia.tarifa;
                    element.subCode = null;
                    element.temporadaSelect = getSeasonSelect();
                    element.tarifas = widget.tarifaXDia.tarifas;
                  }
                }
              }

              if (applyAllNoTariff && !isUnknow) {
                widget.tarifaXDia.subCode = !detectFixInChanges()
                    ? null
                    : UniqueKey().hashCode.toString();

                for (var element in habitacionProvider.tarifaXDia!
                    .where((element) => element.code!.contains("Unknow"))) {
                  element.tarifa = widget.tarifaXDia.tarifa;
                  element.subCode = widget.tarifaXDia.subCode;
                  element.categoria = widget.tarifaXDia.categoria;
                  element.code = widget.tarifaXDia.code;
                  element.color = widget.tarifaXDia.color;
                  element.nombreTariff = widget.tarifaXDia.nombreTariff;
                  element.temporadaSelect = getSeasonSelect();
                  element.temporadas = widget.tarifaXDia.temporadas;
                  element.tarifas = widget.tarifaXDia.tarifas;
                  element.periodo = widget.tarifaXDia.periodo;
                }
              }

              if (applyAllNoTariff && isUnknow) {
                for (var element in habitacionProvider.tarifaXDia!
                    .where((element) => element.code!.contains("Unknow"))) {
                  element.tarifa = widget.tarifaXDia.tarifa;
                  element.tarifas = widget.tarifaXDia.tarifas;
                  element.subCode = null;
                  element.descuentoProvisional =
                      double.parse(_descuentoController.text);
                }

                ref
                    .read(descuentoProvisionalProvider.notifier)
                    .update((state) => double.parse(_descuentoController.text));

                final tarifasProvider = TarifasProvisionalesProvider.provider;

                ref
                    .read(tarifasProvider.notifier)
                    .remove(widget.tarifaXDia.categoria!);
                ref
                    .read(tarifasProvider.notifier)
                    .addItem(widget.tarifaXDia.tarifa!);
              }

              if (!applyAllTariff && !applyAllNoTariff && !widget.isAppling) {
                widget.tarifaXDia.subCode = UniqueKey().hashCode.toString();
              }

              if (applyAllDays) {
                for (var element in habitacionProvider.tarifaXDia!) {
                  element.tarifa =
                      widget.tarifaXDia.copyWith().tarifa!.copyWith();
                  element.nombreTariff =
                      widget.tarifaXDia.copyWith().nombreTariff!;
                  element.code = widget.tarifaXDia.copyWith().code;
                  element.color = widget.tarifaXDia.copyWith().color;
                  element.subCode = null;
                  if (isUnknow || isFreeTariff) {
                    element.descuentoProvisional =
                        double.parse(_descuentoController.text);
                  }

                  element.temporadaSelect = getSeasonSelect();
                  element.temporadas = widget.tarifaXDia
                      .copyWith()
                      .temporadas
                      ?.map((element) => element.copyWith())
                      .toList();
                  element.tarifas = widget.tarifaXDia
                      .copyWith()
                      .tarifas
                      ?.map((element) => element.copyWith())
                      .toList();
                  element.periodo = widget.tarifaXDia.copyWith().periodo;
                }

                if (isUnknow) {
                  ref.read(descuentoProvisionalProvider.notifier).update(
                      (state) => double.parse(_descuentoController.text));

                  ref
                      .read(TarifasProvisionalesProvider.provider.notifier)
                      .addAll(widget.tarifaXDia.tarifas ?? []);
                }
              }

              if (widget.isAppling) {
                widget.tarifaXDia.tarifa = widget.tarifaXDia.tarifas
                    ?.firstWhere((element) =>
                        element.categoria == habitacionProvider.categoria);
              }

              ref
                  .read(detectChangeProvider.notifier)
                  .update((state) => UniqueKey().hashCode);

              Navigator.of(context).pop(true);
            },
          ),
        ),
      ],
    );
  }

  double calculateTariffAdult(int adultos) {
    switch (adultos) {
      case 1 || 2:
        return double.parse(_tarifaAdultoController.text.isEmpty
            ? "0"
            : _tarifaAdultoController.text);

      case 3:
        return double.parse(_tarifaAdultoTPLController.text.isEmpty
            ? "0"
            : _tarifaAdultoTPLController.text);

      case 4:
        return double.parse(_tarifaAdultoCPLController.text.isEmpty
            ? "0"
            : _tarifaAdultoCPLController.text);

      default:
        return double.parse(_tarifaAdultoCPLController.text.isEmpty
            ? "0"
            : _tarifaAdultoCPLController.text);
    }
  }

  double calculateTariffMenor(int menores) =>
      menores *
      double.parse(_tarifaMenoresController.text.isEmpty
          ? "0"
          : _tarifaMenoresController.text);

  TemporadaData? getSeasonSelect() {
    if (widget.tarifaXDia.temporadas != null) {
      return widget.tarifaXDia.temporadas!
          .where((element) => element.nombre == temporadaSelect)
          .firstOrNull;
    } else {
      return null;
    }
  }

  double calculateDiscount(double total) {
    double discount = 0;

    if (getSeasonSelect() != null) {
      discount = (total * 0.01) * getSeasonSelect()!.porcentajePromocion!;
    } else {
      if (isUnknow || isFreeTariff) {
        discount = (total * 0.01) *
            double.parse(_descuentoController.text.isEmpty
                ? '0'
                : _descuentoController.text);
      }
    }

    return discount;
  }

  bool isSameSeason() {
    bool isSame = false;

    if (widget.tarifaXDia.temporadaSelect != null) {
      isSame = widget.tarifaXDia.temporadaSelect!.nombre == temporadaSelect;
    }

    if (isUnknow || isFreeTariff) {
      isSame = double.parse(_descuentoController.text) ==
          widget.tarifaXDia.descuentoProvisional!;
    }

    return isSame;
  }

  bool detectFixInChanges() {
    bool withChanges = false;

    if (!isSameSeason()) return true;
    if (widget.tarifaXDia.tarifa != null &&
        widget.tarifaXDia.tarifa!.categoria ==
            tipoHabitacion[categorias.indexOf(selectCategory)]) {
      if (widget.tarifaXDia.tarifa!.tarifaAdultoSGLoDBL !=
          double.parse(_tarifaAdultoController.text)) return true;
      if (widget.tarifaXDia.tarifa!.tarifaAdultoTPL !=
          double.parse(_tarifaAdultoTPLController.text)) return true;
      if (widget.tarifaXDia.tarifa!.tarifaAdultoCPLE !=
          double.parse(_tarifaAdultoCPLController.text)) return true;
      if (widget.tarifaXDia.tarifa!.tarifaMenores7a12 !=
          double.parse(_tarifaMenoresController.text)) return true;
      if (widget.tarifaXDia.tarifa!.tarifaPaxAdicional !=
          double.parse(_tarifaPaxAdicionalController.text)) return true;

      if (widget.tarifaXDia.tarifas == null) return false;
      TarifaData? secondTariff = widget.tarifaXDia.tarifas
          ?.where((element) => element.categoria == saveTariff!.categoria)
          .firstOrNull;
      if (secondTariff == null) return false;

      if (secondTariff.tarifaAdultoSGLoDBL != saveTariff!.tarifaAdultoSGLoDBL) {
        return true;
      }
      if (secondTariff.tarifaAdultoTPL != saveTariff!.tarifaAdultoTPL) {
        return true;
      }
      if (secondTariff.tarifaAdultoCPLE != saveTariff!.tarifaAdultoCPLE) {
        return true;
      }
      if (secondTariff.tarifaMenores7a12 != saveTariff!.tarifaMenores7a12) {
        return true;
      }
      if (secondTariff.tarifaPaxAdicional != saveTariff!.tarifaPaxAdicional) {
        return true;
      }
    } else if (saveTariff != null &&
        widget.tarifaXDia.tarifa != null &&
        widget.tarifaXDia.tarifa!.categoria !=
            tipoHabitacion[categorias.indexOf(selectCategory)]) {
      if (widget.tarifaXDia.tarifa!.tarifaAdultoSGLoDBL !=
          saveTariff!.tarifaAdultoSGLoDBL) return true;
      if (widget.tarifaXDia.tarifa!.tarifaAdultoTPL !=
          saveTariff!.tarifaAdultoTPL) return true;
      if (widget.tarifaXDia.tarifa!.tarifaAdultoCPLE !=
          saveTariff!.tarifaAdultoCPLE) return true;
      if (widget.tarifaXDia.tarifa!.tarifaMenores7a12 !=
          saveTariff!.tarifaMenores7a12) return true;
      if (widget.tarifaXDia.tarifa!.tarifaPaxAdicional !=
          saveTariff!.tarifaPaxAdicional) return true;

      if (widget.tarifaXDia.tarifas == null) return false;
      TarifaData? secondTariff = widget.tarifaXDia.tarifas
          ?.where((element) =>
              element.categoria ==
              tipoHabitacion[categorias.indexOf(selectCategory)])
          .firstOrNull;
      if (secondTariff == null) return false;

      if (secondTariff.tarifaAdultoSGLoDBL !=
          double.parse(_tarifaAdultoController.text)) return true;
      if (secondTariff.tarifaAdultoTPL !=
          double.parse(_tarifaAdultoTPLController.text)) return true;
      if (secondTariff.tarifaAdultoCPLE !=
          double.parse(_tarifaAdultoCPLController.text)) return true;
      if (secondTariff.tarifaMenores7a12 !=
          double.parse(_tarifaMenoresController.text)) return true;
      if (secondTariff.tarifaPaxAdicional !=
          double.parse(_tarifaPaxAdicionalController.text)) return true;
    }

    return withChanges;
  }

  bool revisedPropiertiesSaveTariff() {
    if (saveTariff?.tarifaAdultoSGLoDBL == null) return true;
    if (saveTariff?.tarifaAdultoTPL == null) return true;
    if (saveTariff?.tarifaAdultoCPLE == null) return true;
    if (saveTariff?.tarifaPaxAdicional == null) return true;
    if (saveTariff?.tarifaMenores7a12 == null) return true;

    return false;
  }

  bool isValidForApplyNotTariff(Habitacion habitacion) {
    bool isValid = false;
    if (isUnknow) return true;
    if (habitacion.tarifaXDia!
        .any((element) => element.code!.contains("Unknow"))) isValid = true;

    return isValid;
  }
}
