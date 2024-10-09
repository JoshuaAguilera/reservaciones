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
  final _formKeyTariffDay = GlobalKey<FormState>();

  List<String> promociones = [];
  final TextEditingController _tarifaAdulto = TextEditingController(text: "0");
  final TextEditingController _tarifaAdultoTPL =
      TextEditingController(text: "0");
  final TextEditingController _tarifaAdultoCPL =
      TextEditingController(text: "0");
  final TextEditingController _tarifaMenores = TextEditingController(text: "0");
  final TextEditingController _tarifaPaxAdicional =
      TextEditingController(text: "0");

  @override
  void initState() {
    tarifaSelect = widget.tarifaXDia.temporadaSelect?.nombre ?? 'No aplicar';
    promociones.add("No aplicar");

    if (widget.tarifaXDia.tarifa != null) {
      _tarifaAdulto.text =
          widget.tarifaXDia.tarifa!.tarifaAdultoSGLoDBL!.toString();
      _tarifaAdultoTPL.text =
          widget.tarifaXDia.tarifa!.tarifaAdultoTPL!.toString();
      _tarifaAdultoCPL.text =
          widget.tarifaXDia.tarifa!.tarifaAdultoCPLE!.toString();
      _tarifaMenores.text =
          widget.tarifaXDia.tarifa!.tarifaMenores7a12!.toString();
      _tarifaPaxAdicional.text =
          widget.tarifaXDia.tarifa!.tarifaPaxAdicional.toString();
    }

    for (var element in widget.tarifaXDia.temporadas!) {
      promociones.add(element.nombre);
    }
    super.initState();
  }

  @override
  void dispose() {
    _tarifaAdulto.dispose();
    _tarifaAdultoTPL.dispose();
    _tarifaAdultoCPL.dispose();
    _tarifaMenores.dispose();
    _tarifaPaxAdicional.dispose();
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
                      "Modificar tarifa del ${Utility.getCompleteDate(data: widget.tarifaXDia.fecha)} \nTarifa aplicada: ${widget.tarifaXDia.nombreTarif}",
                  size: 16,
                  color: Theme.of(context).primaryColor))
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStyles.standardText(
                      text: "Temporada: ",
                      overClip: true,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10),
                    CustomDropdown.dropdownMenuCustom(
                      initialSelection: tarifaSelect,
                      onSelected: (String? value) =>
                          setState(() => tarifaSelect = value!),
                      elements: promociones,
                      screenWidth: 500,
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
                        controller: _tarifaAdulto,
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
                        controller: _tarifaAdultoTPL,
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
                        controller: _tarifaAdultoCPL,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Tarifa Pax Adic",
                        isMoneda: true,
                        isNumeric: true,
                        isDecimal: true,
                        controller: _tarifaPaxAdicional,
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
                        controller: _tarifaMenores,
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
                          Row(
                            children: [
                              SizedBox(
                                height: 35,
                                width: 30,
                                child: Checkbox(
                                  value: applyAllTariff,
                                  onChanged: (value) => setState(() {
                                    applyAllTariff = value!;
                                    applyAllDays = false;
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
                                text: "Aplicar en toda la tarifa",
                                color: Theme.of(context).primaryColor,
                                size: 12,
                              )
                            ],
                          ),
                          TextStyles.standardText(
                              text:
                                  "(Esta opción aplicara los siguientes cambios en todos los periodos de la tarifa actual: \"${widget.tarifaXDia.nombreTarif}\").",
                              color: Theme.of(context).primaryColor,
                              size: 10,
                              overClip: true,
                              aling: TextAlign.justify),
                          const SizedBox(height: 30),
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
                                count: -discount,
                                context: context,
                                height: 40),
                            Divider(color: Theme.of(context).primaryColor),
                            const SizedBox(height: 5),
                            CustomWidgets.itemListCount(
                                nameItem: "Total del dia(s):",
                                count:
                                    (tariffChildren + tariffAdult) - discount,
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

              TarifaData newTarifa = widget.tarifaXDia.tarifa!;

              widget.tarifaXDia.tarifa = TarifaData(
                id: newTarifa.id,
                code: newTarifa.code,
                categoria: newTarifa.categoria,
                fecha: newTarifa.fecha,
                tarifaAdultoSGLoDBL: double.parse(_tarifaAdulto.text),
                tarifaAdultoTPL: double.parse(_tarifaAdultoTPL.text),
                tarifaAdultoCPLE: double.parse(_tarifaAdultoCPL.text),
                tarifaMenores7a12: double.parse(_tarifaMenores.text),
                tarifaPaxAdicional: double.parse(_tarifaPaxAdicional.text),
              );

              widget.tarifaXDia.temporadaSelect = getSeasonSelect();

              if (applyAllTariff) {
                for (var element in habitacionProvider.tarifaXDia!) {
                  if (element.code == widget.tarifaXDia.code) {
                    element.tarifa = widget.tarifaXDia.tarifa;
                    element.temporadaSelect = getSeasonSelect();
                  }
                }

                ref
                    .read(detectChangeProvider.notifier)
                    .update((state) => UniqueKey().hashCode);
              }
            },
          ),
        ),
      ],
    );
  }

  double calculateTariffAdult(int adultos) {
    switch (adultos) {
      case 1 || 2:
        return double.parse(
            _tarifaAdulto.text.isEmpty ? "0" : _tarifaAdulto.text);

      case 3:
        return double.parse(
            _tarifaAdultoTPL.text.isEmpty ? "0" : _tarifaAdultoTPL.text);

      case 4:
        return double.parse(
            _tarifaAdultoCPL.text.isEmpty ? "0" : _tarifaAdultoCPL.text);

      default:
        return double.parse(
            _tarifaAdultoCPL.text.isEmpty ? "0" : _tarifaAdultoCPL.text);
    }
  }

  double calculateTariffMenor(int menores) =>
      menores *
      double.parse(_tarifaMenores.text.isEmpty ? "0" : _tarifaMenores.text);

  TemporadaData? getSeasonSelect() => widget.tarifaXDia.temporadas!
      .where((element) => element.nombre == tarifaSelect)
      .firstOrNull;

  double calculateDiscount(double total) {
    double discount = 0;

    if (getSeasonSelect() != null) {
      discount = (total * 0.01) * getSeasonSelect()!.porcentajePromocion!;
    }

    return discount;
  }

  bool isSameSeason() {
    bool isSame = false;
    isSame = widget.tarifaXDia.temporadaSelect!.nombre == tarifaSelect;
    return isSame;
  }

  bool detectFixInChanges() {
    bool withChanges = false;

    if (!isSameSeason()) return true;
    if (widget.tarifaXDia.tarifa!.tarifaAdultoSGLoDBL !=
        double.parse(_tarifaAdulto.text)) return true;
    if (widget.tarifaXDia.tarifa!.tarifaAdultoTPL !=
        double.parse(_tarifaAdultoTPL.text)) return true;
    if (widget.tarifaXDia.tarifa!.tarifaAdultoCPLE !=
        double.parse(_tarifaAdultoCPL.text)) return true;
    if (widget.tarifaXDia.tarifa!.tarifaMenores7a12 !=
        double.parse(_tarifaMenores.text)) return true;
    if (widget.tarifaXDia.tarifa!.tarifaPaxAdicional !=
        double.parse(_tarifaPaxAdicional.text)) return true;

    return withChanges;
  }
}
