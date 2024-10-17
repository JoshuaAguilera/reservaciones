import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
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
  const ManagerTariffDayWidget(
      {super.key, required this.tarifaXDia, this.isAppling = false});

  final TarifaXDia tarifaXDia;
  final bool isAppling;

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
  bool isFreeTariff = false;
  final _formKeyTariffDay = GlobalKey<FormState>();

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
                text: widget.isAppling
                    ? "Aplicar nueva Tarifa libre de ${Utility.getStringPeriod(initDate: DateTime.parse(habitacionProvider.fechaCheckIn!), lastDate: DateTime.parse(habitacionProvider.fechaCheckOut!))}\nen categoria: ${habitacionProvider.categoria}"
                    : "Modificar tarifa del ${Utility.getCompleteDate(data: widget.tarifaXDia.fecha)} \nTarifa aplicada: ${widget.tarifaXDia.nombreTarif} ${widget.tarifaXDia.subCode != null ? "(modificada)" : ""}",
                size:
                    (widget.tarifaXDia.subCode != null && !isUnknow) ? 13 : 16,
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
                        excepcionItem: "No aplicar",
                        notElements:
                            getPromocionesNoValidas(habitacionProvider),
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
                        enabled: false,
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
                          if (isValidForApplyNotTariff(habitacionProvider) &&
                              !widget.isAppling &&
                              !isFreeTariff)
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
                          if (!isUnknow && !widget.isAppling && !isFreeTariff)
                            CustomWidgets.checkBoxWithDescription(
                              context,
                              activeColor: widget.tarifaXDia.color,
                              title: "Aplicar en toda la tarifa",
                              description:
                                  "(Esta opción aplicara los siguientes cambios en todos los periodos de la tarifa actual: \"${widget.tarifaXDia.nombreTarif}${widget.tarifaXDia.subCode != null ? " [modificado]" : ""}\").",
                              value: applyAllTariff,
                              onChanged: (value) => setState(() {
                                applyAllTariff = value!;
                                applyAllNoTariff = false;
                                applyAllDays = false;
                              }),
                            ),
                          if (!widget.isAppling)
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
                                    "Descuento (${(getSeasonSelect() != null) ? getSeasonSelect()?.porcentajePromocion ?? 0 : _descuentoController.text}%):",
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

              if (!detectFixInChanges() &&
                  widget.tarifaXDia.tarifa != null &&
                  !applyAllDays &&
                  !applyAllNoTariff &&
                  !applyAllDays) {
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
                  element.nombreTarif = widget.tarifaXDia.nombreTarif;
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
                  element.tarifa = widget.tarifaXDia.tarifa;
                  element.nombreTarif = widget.tarifaXDia.nombreTarif!;
                  element.code = widget.tarifaXDia.code;
                  element.color = widget.tarifaXDia.color;
                  element.subCode = null;
                  if (isUnknow || isFreeTariff) {
                    element.descuentoProvisional =
                        double.parse(_descuentoController.text);
                  }

                  element.temporadaSelect = getSeasonSelect();
                  element.temporadas = widget.tarifaXDia.temporadas;
                  element.tarifas = widget.tarifaXDia.tarifas;
                  element.periodo = widget.tarifaXDia.periodo;
                }

                if (isUnknow) {
                  ref.read(descuentoProvisionalProvider.notifier).update(
                      (state) => double.parse(_descuentoController.text));

                  final tarifasProvider = TarifasProvisionalesProvider.provider;

                  ref
                      .read(tarifasProvider.notifier)
                      .remove(widget.tarifaXDia.categoria!);
                  ref
                      .read(tarifasProvider.notifier)
                      .addItem(widget.tarifaXDia.tarifa!);
                }
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
      if (isUnknow) {
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
      isSame = widget.tarifaXDia.temporadaSelect!.nombre == tarifaSelect;
    }

    if (isUnknow) {
      isSame = double.parse(_descuentoController.text) ==
          widget.tarifaXDia.descuentoProvisional!;
    }

    return isSame;
  }

  bool detectFixInChanges() {
    bool withChanges = false;

    if (!isSameSeason()) return true;
    if (widget.tarifaXDia.tarifa != null) {
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
    }

    // if (applyAllDays) return true;
    // if (applyAllNoTariff) return true;
    // if (applyAllTariff) return true;

    return withChanges;
  }

  List<String>? getPromocionesNoValidas(Habitacion habitacion) {
    if (widget.tarifaXDia.temporadas == null) return null;
    if (widget.tarifaXDia.temporadas!.isEmpty) return null;

    int totalEstancia = DateTime.parse(habitacion.fechaCheckOut!)
        .difference(DateTime.parse(habitacion.fechaCheckIn!))
        .inDays;

    List<String> promocionesNoValidas = [];

    for (var element in widget.tarifaXDia.temporadas!) {
      if (element.estanciaMinima! <= totalEstancia) {
        promocionesNoValidas.add(element.nombre);
      }
    }

    if (promocionesNoValidas.isEmpty) return null;

    return promocionesNoValidas;
  }

  bool isValidForApplyNotTariff(Habitacion habitacion) {
    bool isValid = false;
    if (isUnknow) return true;
    if (habitacion.tarifaXDia!
        .any((element) => element.code!.contains("Unknow"))) isValid = true;

    return isValid;
  }
}
