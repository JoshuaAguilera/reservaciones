import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/ui/buttons.dart';

import '../providers/habitacion_provider.dart';
import '../ui/custom_widgets.dart';
import '../utils/helpers/utility.dart';
import '../utils/helpers/web_colors.dart';
import 'custom_dropdown.dart';
import 'text_styles.dart';
import 'textformfield_custom.dart';

class ManagerTariffDayWidget extends ConsumerStatefulWidget {
  const ManagerTariffDayWidget({super.key, required this.tarifaXDia});

  final TarifaXDia tarifaXDia;

  @override
  _ManagerTariffDayWidgetState createState() => _ManagerTariffDayWidgetState();
}

class _ManagerTariffDayWidgetState
    extends ConsumerState<ManagerTariffDayWidget> {
  String tarifaSelect = "Mayo - Abril";
  bool applyAllTariff = false;
  bool applyAllDays = false;
  bool applyAllNoTariff = false;
  bool isUnknow = false;
  final _formKeyTariffDay = GlobalKey<FormState>();

  List<String> promociones = [];
  final TextEditingController _tarifaAdultoController =
      TextEditingController(text: "0");
  final TextEditingController _tarifaAdultoTPLController =
      TextEditingController(text: "0");
  final TextEditingController _tarifaAdultoCPLController =
      TextEditingController(text: "0");
  final TextEditingController _tarifaMenoresController =
      TextEditingController(text: "0");
  final TextEditingController _tarifaPaxAdicionalController =
      TextEditingController(text: "0");
  final TextEditingController _descuentoController = TextEditingController();

  @override
  void initState() {
    _descuentoController.text =
        widget.tarifaXDia.descuentoProvisional.toString();
    isUnknow = widget.tarifaXDia.code!.contains("Unknow");
    tarifaSelect = widget.tarifaXDia.temporadaSelect?.nombre ?? 'No aplicar';
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
    }

    if (widget.tarifaXDia.temporadas != null) {
      for (var element in widget.tarifaXDia.temporadas!) {
        promociones.add(element.nombre);
      }
    }
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

    return AlertDialog(
      elevation: 15,
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
                text:
                    "Modificar tarifa del ${Utility.getCompleteDate(data: widget.tarifaXDia.fecha)} \nTarifa aplicada: ${widget.tarifaXDia.nombreTarif} ${widget.tarifaXDia.subCode != null ? "(modificada)" : ""}",
                size: (widget.tarifaXDia.subCode != null) ? 13 : 16,
                color: Theme.of(context).primaryColor),
          ),
        ],
      ),
      content: SizedBox(
        height: 550,
        child: Form(
          key: _formKeyTariffDay,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: widget.tarifaXDia.temporadaSelect != null
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    TextStyles.standardText(
                      text: widget.tarifaXDia.temporadaSelect != null
                          ? "Temporada: "
                          : "Descuento: ",
                      overClip: true,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10),
                    if (widget.tarifaXDia.temporadas != null &&
                        widget.tarifaXDia.temporadas!.isNotEmpty)
                      CustomDropdown.dropdownMenuCustom(
                        initialSelection: tarifaSelect,
                        onSelected: (String? value) =>
                            setState(() => tarifaSelect = value!),
                        elements: promociones,
                        screenWidth: 500,
                      )
                    else
                      SizedBox(
                        width: 135,
                        height: 50,
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Porcentaje",
                          controller: _descuentoController,
                          icon: const Icon(CupertinoIcons.percent, size: 20),
                          isNumeric: true,
                          onChanged: (p0) => setState(() {}),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Tarifa SGL/DBL",
                        isMoneda: true,
                        isNumeric: true,
                        isDecimal: true,
                        onChanged: (p0) => setState(() {}),
                        controller: _tarifaAdultoController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Tarifa TPL",
                        isMoneda: true,
                        isNumeric: true,
                        isDecimal: true,
                        onChanged: (p0) => setState(() {}),
                        controller: _tarifaAdultoTPLController,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Tarifa CPLE",
                        isMoneda: true,
                        isNumeric: true,
                        isDecimal: true,
                        onChanged: (p0) => setState(() {}),
                        controller: _tarifaAdultoCPLController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Tarifa Pax Adic",
                        isMoneda: true,
                        isNumeric: true,
                        isDecimal: true,
                        controller: _tarifaPaxAdicionalController,
                        onChanged: (p0) => setState(() {}),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Tarifa Menores 7 a 12 años",
                        isMoneda: true,
                        isNumeric: true,
                        isDecimal: true,
                        controller: _tarifaMenoresController,
                        onChanged: (p0) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Tarifa Menores 0 a 6 años",
                        isMoneda: true,
                        isNumeric: true,
                        isDecimal: true,
                        blocked: true,
                        initialValue: "GRATIS",
                      ),
                    ),
                  ],
                ),
                Divider(color: Theme.of(context).primaryColor),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    width: 30,
                                    child: Checkbox(
                                      value: isUnknow
                                          ? applyAllNoTariff
                                          : applyAllTariff,
                                      onChanged: (value) => setState(() {
                                        isUnknow
                                            ? applyAllNoTariff = value!
                                            : applyAllTariff = value!;
                                        applyAllDays = false;
                                      }),
                                      activeColor: widget.tarifaXDia.color ??
                                          Colors.amber,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextStyles.standardText(
                                      text: isUnknow
                                          ? "Aplicar en dias sin tarifa definida"
                                          : "Aplicar en toda la tarifa",
                                      color: Theme.of(context).primaryColor,
                                      size: 12,
                                      overClip: true,
                                    ),
                                  )
                                ],
                              ),
                              TextStyles.standardText(
                                  text: isUnknow
                                      ? "(Esta opción aplicara los siguientes cambios en todos los dias que no esten en el margen de las tarifas definidas)."
                                      : "(Esta opción aplicara los siguientes cambios en todos los periodos de la tarifa actual: \"${widget.tarifaXDia.nombreTarif}\").",
                                  color: Theme.of(context).primaryColor,
                                  size: 10,
                                  overClip: true,
                                  aling: TextAlign.justify),
                              const SizedBox(height: 30),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 35,
                                width: 30,
                                child: Checkbox(
                                  value: applyAllDays,
                                  onChanged: (value) => setState(() {
                                    applyAllDays = value!;
                                    applyAllTariff = false;
                                    applyAllNoTariff = false;
                                  }),
                                  activeColor:
                                      widget.tarifaXDia.color ?? Colors.amber,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3),
                                    ),
                                  ),
                                ),
                              ),
                              TextStyles.standardText(
                                text: "Aplicar en todos los dias",
                                color: Theme.of(context).primaryColor,
                                size: 12,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    StatefulBuilder(builder: (context, snapshot) {
                      double tariffAdult =
                          calculateTariffAdult(habitacionProvider.adultos!);
                      double tariffChildren =
                          calculateTariffMenor(habitacionProvider.menores7a12!);
                      double discount =
                          calculateDiscount(tariffAdult + tariffChildren);

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
                            Divider(color: Theme.of(context).primaryColor),
                            const SizedBox(height: 5),
                            CustomWidgets.itemListCount(
                                nameItem: "Total:",
                                count: tariffAdult + tariffChildren,
                                context: context,
                                height: 40),
                            CustomWidgets.itemListCount(
                                nameItem:
                                    "Descuento (${getSeasonSelect()?.porcentajePromocion ?? 0}%):",
                                count: -discount.round() + 0.0,
                                context: context,
                                height: 40),
                            Divider(color: Theme.of(context).primaryColor),
                            const SizedBox(height: 5),
                            CustomWidgets.itemListCount(
                                nameItem: "Total del dia(s):",
                                count:
                                    ((tariffChildren + tariffAdult) - discount)
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

              if (!detectFixInChanges()) {
                print("sin cambios");
                Navigator.pop(context);
                return;
              }

              TarifaData? newTarifa = widget.tarifaXDia.tarifa;

              widget.tarifaXDia.tarifa = TarifaData(
                id: newTarifa?.id ?? 0,
                code: newTarifa?.code ?? widget.tarifaXDia.code ?? '',
                categoria: newTarifa?.categoria ?? widget.tarifaXDia.categoria,
                fecha: newTarifa?.fecha ?? DateTime.now(),
                tarifaAdultoSGLoDBL: double.parse(_tarifaAdultoController.text),
                tarifaAdultoTPL: double.parse(_tarifaAdultoTPLController.text),
                tarifaAdultoCPLE: double.parse(_tarifaAdultoCPLController.text),
                tarifaMenores7a12: double.parse(_tarifaMenoresController.text),
                tarifaPaxAdicional:
                    double.parse(_tarifaPaxAdicionalController.text),
              );

              widget.tarifaXDia.temporadaSelect = getSeasonSelect();
              widget.tarifaXDia.descuentoProvisional =
                  double.parse(_descuentoController.text);

              if (applyAllTariff) {
                for (var element in habitacionProvider.tarifaXDia!) {
                  if (element.code == widget.tarifaXDia.code) {
                    element.tarifa = widget.tarifaXDia.tarifa;
                    element.temporadaSelect = getSeasonSelect();
                  }
                }
                widget.tarifaXDia.subCode = null;

                ref
                    .read(detectChangeProvider.notifier)
                    .update((state) => UniqueKey().hashCode);
              }

              if (applyAllNoTariff) {
                for (var element in habitacionProvider.tarifaXDia!
                    .where((element) => element.code!.contains("Unknow"))) {
                  element.tarifa = widget.tarifaXDia.tarifa;
                  element.descuentoProvisional = double.parse(_descuentoController.text);
                }

                widget.tarifaXDia.subCode = null;

                ref
                    .read(detectChangeProvider.notifier)
                    .update((state) => UniqueKey().hashCode);
              }

              if (!applyAllTariff && !applyAllNoTariff) {
                widget.tarifaXDia.subCode = UniqueKey().hashCode.toString();
              }

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
          .where((element) => element.nombre == tarifaSelect)
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
      discount = (total * 0.01) *
          double.parse(_descuentoController.text.isEmpty
              ? '0'
              : _descuentoController.text);
    }

    return discount;
  }

  bool isSameSeason() {
    bool isSame = false;
    if (widget.tarifaXDia.temporadaSelect != null)
      isSame = widget.tarifaXDia.temporadaSelect!.nombre == tarifaSelect;
    return isSame;
  }

  bool detectFixInChanges() {
    bool withChanges = false;

    if (!isSameSeason()) return true;
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

    return withChanges;
  }
}
