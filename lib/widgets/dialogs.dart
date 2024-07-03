import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/widgets/custom_widgets.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:generador_formato/widgets/number_input_with_increment_decrement.dart';

import '../helpers/constants.dart';
import '../models/cotizacion_model.dart';

class Dialogs {
  Widget habitacionIndividualDialog(
      {required BuildContext buildContext, Cotizacion? cotizacion}) {
    Cotizacion nuevaCotizacion = cotizacion ??
        Cotizacion(
          categoria: categorias.first,
          plan: planes.first,
          fechaEntrada: DateTime.now().toString().substring(0, 10),
          adultos: 0,
          menores0a6: 0,
          menores7a12: 0,
        );
    final _formKeyHabitacion = GlobalKey<FormState>();
    TextEditingController _fechaEntrada = TextEditingController(
        text: cotizacion != null
            ? cotizacion.fechaEntrada
            : DateTime.now().toString().substring(0, 10));
    TextEditingController _fechaSalida = TextEditingController(
        text: cotizacion != null
            ? cotizacion.fechaSalida
            : DateTime.now()
                .add(const Duration(days: 1))
                .toString()
                .substring(0, 10));
    bool esOferta = cotizacion != null ? cotizacion.esPreVenta!  : false;
    bool isError = false;

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        title: TextStyles.titleText(
            text: cotizacion != null ? "Editar" : "Agregar" " cotización",
            color: DesktopColors.prussianBlue),
        content: SingleChildScrollView(
          child: Form(
            key: _formKeyHabitacion,
            child: Column(
              children: [
                CheckboxListTile.adaptive(
                  title: TextStyles.standardText(
                      text:
                          "Cotización con preventa oferta de tiempo limitado"),
                  value: esOferta,
                  onChanged: (value) {
                    setState(() {
                      esOferta = value!;
                    });
                    if (!value!) {
                      Future.delayed(Durations.medium1, () {
                        if (_formKeyHabitacion.currentState!.validate()) {}
                      });
                    }
                  },
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  contentPadding: const EdgeInsets.all(0),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextStyles.standardText(
                            text: "Categoría: ", overClip: true)),
                    const SizedBox(width: 15),
                    CustomWidgets.dropdownMenuCustom(
                        initialSelection: cotizacion != null
                            ? cotizacion.categoria!
                            : categorias.first,
                        onSelected: (String? value) {
                          nuevaCotizacion.categoria = value!;
                        },
                        elements: categorias,
                        screenWidth: MediaQuery.of(context).size.width),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextStyles.standardText(
                            text: "Plan: ", overClip: true)),
                    const SizedBox(width: 15),
                    CustomWidgets.dropdownMenuCustom(
                        initialSelection: cotizacion != null
                            ? cotizacion.plan!
                            : planes.first,
                        onSelected: (String? value) {
                          nuevaCotizacion.plan = value!;
                        },
                        elements: planes,
                        screenWidth: MediaQuery.of(context).size.width),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child:
                          TextFormFieldCustom.textFormFieldwithBorderCalendar(
                        name: "Fecha de entrada",
                        msgError: "Campo requerido*",
                        dateController: _fechaEntrada,
                        onChanged: () => setState(
                          () {
                            _fechaSalida.text =
                                Utility.getNextDay(_fechaEntrada.text);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:
                          TextFormFieldCustom.textFormFieldwithBorderCalendar(
                        name: "Fecha de salida",
                        msgError: "Campo requerido*",
                        dateController: _fechaSalida,
                        fechaLimite: _fechaEntrada.text,
                      ),
                    ),
                  ],
                ),
                Table(
                  children: [
                    TableRow(children: [
                      TextStyles.standardText(
                          text: "Adultos", aling: TextAlign.center),
                      const SizedBox(),
                      const SizedBox()
                    ]),
                    TableRow(children: [
                      NumberInputWithIncrementDecrement(
                        onChanged: (p0) => setState(
                            () => nuevaCotizacion.adultos = int.tryParse(p0)),
                        initialValue: cotizacion?.adultos!.toString(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 150,
                          child: TextFormFieldCustom.textFormFieldwithBorder(
                              name: "Tarifa adulto",
                              msgError: "Campo requerido*",
                              isNumeric: true,
                              isDecimal: true,
                              isMoneda: true,
                              initialValue: cotizacion != null
                                  ? (nuevaCotizacion.tarifaRealAdulto ?? "")
                                      .toString()
                                  : null,
                              onChanged: (p0) => setState(() => nuevaCotizacion
                                  .tarifaRealAdulto = double.tryParse(p0)),
                              isRequired: nuevaCotizacion.adultos! > 0),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Tarifa preventa adulto",
                          msgError: "Campo requerido*",
                          isNumeric: true,
                          enabled: esOferta,
                          isRequired:
                              esOferta && (nuevaCotizacion.adultos! > 0),
                          isDecimal: true,
                          isMoneda: true,
                          initialValue: cotizacion != null
                              ? (cotizacion.tarifaPreventaAdulto ?? "")
                                  .toString()
                              : null,
                          onChanged: (p0) => setState(() => nuevaCotizacion
                              .tarifaPreventaAdulto = double.tryParse(p0)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TextStyles.standardText(
                          text: "Menores 7-12", aling: TextAlign.center),
                      const SizedBox(),
                      const SizedBox()
                    ]),
                    TableRow(children: [
                      NumberInputWithIncrementDecrement(
                        onChanged: (p0) => setState(() =>
                            nuevaCotizacion.menores7a12 = int.tryParse(p0)),
                        initialValue: cotizacion?.menores7a12!.toString(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 150,
                          child: TextFormFieldCustom.textFormFieldwithBorder(
                              name: "Tarifa menores",
                              msgError: "Campo requerido*",
                              isNumeric: true,
                              isDecimal: true,
                              isMoneda: true,
                              initialValue: cotizacion != null
                                  ? (nuevaCotizacion.tarifaRealMenor ?? "")
                                      .toString()
                                  : null,
                              onChanged: (p0) => setState(() => nuevaCotizacion
                                  .tarifaRealMenor = double.tryParse(p0)),
                              isRequired: nuevaCotizacion.menores7a12! > 0),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Tarifa preventa menores",
                          msgError: "Campo requerido*",
                          isNumeric: true,
                          isDecimal: true,
                          isMoneda: true,
                          isRequired:
                              esOferta && (nuevaCotizacion.menores7a12! > 0),
                          enabled: esOferta,
                          initialValue: cotizacion != null
                              ? (cotizacion.tarifaPreventaMenor ?? "")
                                  .toString()
                              : null,
                          onChanged: (p0) => setState(() => nuevaCotizacion
                              .tarifaPreventaMenor = double.tryParse(p0)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TextStyles.standardText(
                          text: "Menores 0-6", aling: TextAlign.center),
                      const SizedBox(),
                      const SizedBox()
                    ]),
                    TableRow(children: [
                      NumberInputWithIncrementDecrement(
                        onChanged: (p0) => setState(() =>
                            nuevaCotizacion.menores0a6 = int.tryParse(p0)),
                        initialValue: cotizacion?.menores0a6!.toString(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: SizedBox(
                          child: Center(
                            child: esOferta
                                ? TextStyles.standardText(
                                    aling: TextAlign.right,
                                    size: 15,
                                    overClip: true,
                                    text:
                                        "Tarifa preventa diaria: ${Utility.formatterNumber(Utility.calculateTarifaDiaria(cotizacion: nuevaCotizacion, esPreventa: true))}",
                                    isBold: true,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: SizedBox(
                          child: TextStyles.standardText(
                            aling: TextAlign.right,
                            size: 15,
                            overClip: true,
                            text:
                                "Tarifa real diaria: ${Utility.formatterNumber(Utility.calculateTarifaDiaria(cotizacion: nuevaCotizacion))}",
                            isBold: true,
                          ),
                        ),
                      )
                    ])
                  ],
                ),
                SizedBox(
                    height: 16,
                    child: isError
                        ? TextStyles.errorText(
                            text:
                                "Se requiere de al menos un adulto para generar la reservación",
                            size: 12)
                        : null),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (_formKeyHabitacion.currentState!.validate()) {
                  nuevaCotizacion.fechaEntrada = _fechaEntrada.text;
                  nuevaCotizacion.fechaSalida = _fechaSalida.text;
                  nuevaCotizacion.esPreVenta = esOferta;
                  if (nuevaCotizacion.adultos == 0) {
                    setState(() => isError = true);
                    return;
                  } else {
                    setState(() => isError = false);
                  }

                  Navigator.of(buildContext).pop(nuevaCotizacion);
                }
              },
              child: TextStyles.buttonText(
                  text: cotizacion != null ? "Editar" : "Agregar")),
          TextButton(
              onPressed: () {
                Navigator.pop(buildContext);
              },
              child: TextStyles.buttonText(text: "Cancelar"))
        ],
      );
    });
  }

  Widget habitacionGrupoDialog(
      {required BuildContext buildContext, Cotizacion? cotizacion}) {
    Cotizacion nuevaCotizacion = cotizacion ??
        Cotizacion(
          tipoHabitacion: tipoHabitacion.first,
          plan: planes.first,
          fechaEntrada: DateTime.now().toString().substring(0, 10),
          adultos: 0,
          menores7a12: 0,
        );
    int pax = 1;
    bool tryAdulto = false;
    bool tryMenores = false;
    final _formKeyHabitacion = GlobalKey<FormState>();
    TextEditingController _fechaEntrada = TextEditingController(
        text: cotizacion != null
            ? cotizacion.fechaEntrada
            : DateTime.now().toString().substring(0, 10));
    TextEditingController _subtotalController = TextEditingController(
        text: cotizacion != null
            ? Utility.formatterNumber(nuevaCotizacion.subtotal!)
            : Utility.formatterNumber(0));
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      title: TextStyles.titleText(
          text: cotizacion != null ? "Editar habitación" : "Agregar habitación",
          color: DesktopColors.prussianBlue),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Form(
              key: _formKeyHabitacion,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: TextStyles.standardText(
                              text: "Tipo de habitacion: ", overClip: true)),
                      const SizedBox(width: 15),
                      CustomWidgets.dropdownMenuCustom(
                          initialSelection: cotizacion != null
                              ? cotizacion.tipoHabitacion!
                              : tipoHabitacion.first,
                          onSelected: (String? value) {
                            nuevaCotizacion.tipoHabitacion = value!;
                          },
                          elements: tipoHabitacion,
                          screenWidth: MediaQuery.of(context).size.width),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: TextStyles.standardText(
                              text: "Plan: ", overClip: true)),
                      const SizedBox(width: 15),
                      CustomWidgets.dropdownMenuCustom(
                          initialSelection: cotizacion != null
                              ? cotizacion.plan!
                              : planes.first,
                          onSelected: (String? value) {
                            nuevaCotizacion.plan = value!;
                          },
                          elements: planes,
                          screenWidth: MediaQuery.of(context).size.width),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child:
                            TextFormFieldCustom.textFormFieldwithBorderCalendar(
                          name: "Fecha de entrada",
                          msgError: "Campo requerido*",
                          dateController: _fechaEntrada,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  Table(
                    children: [
                      TableRow(children: [
                        TextStyles.standardText(
                            text: "Pax", aling: TextAlign.center),
                        TextStyles.standardText(
                            text: "Adultos", aling: TextAlign.center),
                        TextStyles.standardText(
                            text: "Menores 7-12", aling: TextAlign.center),
                      ]),
                      TableRow(children: [
                        NumberInputWithIncrementDecrement(
                          onChanged: (p0) {
                            if (int.parse(p0) < 5) {
                              pax = int.tryParse(p0)!;
                            }
                          },
                          initialValue: cotizacion != null
                              ? cotizacion.pax.toString()
                              : "1",
                          minimalValue: 1,
                          maxValue: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: NumberInputWithIncrementDecrement(
                            onChanged: (p0) {
                              if (int.parse(p0) < 5) {
                                nuevaCotizacion.adultos = int.tryParse(p0)!;
                                setState(() => tryAdulto = false);
                              } else {
                                setState(() => tryAdulto = true);
                              }
                            },
                            initialValue: cotizacion?.adultos!.toString(),
                          ),
                        ),
                        NumberInputWithIncrementDecrement(
                          onChanged: (p0) {
                            nuevaCotizacion.menores7a12 = int.tryParse(p0);
                          },
                          initialValue: cotizacion?.menores7a12!.toString(),
                        ),
                      ]),
                      TableRow(children: [
                        const SizedBox(),
                        if (tryAdulto)
                          SizedBox(
                            height: 25,
                            child: TextStyles.errorText(
                                text: "Limite alcanzado*",
                                aling: TextAlign.center),
                          )
                        else
                          const SizedBox(),
                        const SizedBox(),
                        // TextStyles.errorText(
                        //     text: "Limite alcanzado*", aling: TextAlign.center),
                      ]),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Tarifa noche",
                          msgError: "Campo requerido*",
                          isNumeric: true,
                          isDecimal: true,
                          isMoneda: true,
                          initialValue: cotizacion != null
                              ? nuevaCotizacion.tarifaNoche!.toString()
                              : null,
                          onChanged: (p0) {
                            nuevaCotizacion.tarifaNoche = double.tryParse(p0);
                            _subtotalController.text = Utility.calculateTotal(
                              7,
                              nuevaCotizacion.tarifaNoche,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Subtotal",
                          msgError: "",
                          isRequired: false,
                          isNumeric: true,
                          isDecimal: true,
                          isMoneda: true,
                          blocked: true,
                          controller: _subtotalController,
                          onChanged: (p0) {
                            nuevaCotizacion.subtotal = double.tryParse(p0);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (_formKeyHabitacion.currentState!.validate()) {
                nuevaCotizacion.fechaEntrada = _fechaEntrada.text;
                nuevaCotizacion.subtotal = double.parse(
                    _subtotalController.text.replaceAll(RegExp(r"[$,]"), ""));
                nuevaCotizacion.pax = pax;
                Navigator.of(buildContext).pop(nuevaCotizacion);
              }
            },
            child: TextStyles.buttonText(
                text: cotizacion != null ? "Editar" : "Agregar")),
        TextButton(
            onPressed: () {
              Navigator.pop(buildContext);
            },
            child: TextStyles.buttonText(text: "Cancelar"))
      ],
    );
  }

  String getPax(int pax) {
    String paxName = "";

    switch (pax) {
      case 1 || 2:
        paxName = "1 o 2";
        break;
      case 3:
        paxName = "3";
        break;
      case 4:
        paxName = "4";
        break;
      default:
    }
    return paxName;
  }

  static AlertDialog customAlertDialog({
    IconData? iconData,
    required BuildContext context,
    required String title,
    required String content,
    String? contentBold,
    required String nameButtonMain,
    required VoidCallback funtionMain,
    required String nameButtonCancel,
    required bool withButtonCancel,
  }) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      title: Row(children: [
        if (iconData != null)
          Icon(
            iconData,
            size: 33,
            color: DesktopColors.ceruleanOscure,
          ),
        const SizedBox(width: 10),
        Expanded(
            child: TextStyles.titleText(
                text: title, color: Colors.black, size: 18))
      ]),
      content: TextStyles.TextAsociative(contentBold ?? "", content,
          isInverted: contentBold != null),
      actions: [
        if (withButtonCancel)
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextStyles.buttonText(text: nameButtonCancel)),
        TextButton(
          onPressed: () {
            funtionMain.call();
            Navigator.of(context).pop(true);
          },
          child: TextStyles.buttonText(
            text: nameButtonMain,
          ),
        ),
      ],
    );
  }

  static AlertDialog filterDateDialog({
    required BuildContext context,
    required VoidCallback funtionMain,
  }) {
    final TextEditingController _initDateController = TextEditingController(
        text: DateTime.now()
            .subtract(const Duration(days: 30))
            .toIso8601String()
            .substring(0, 10));
    final TextEditingController _endDateController = TextEditingController(
        text: DateTime.now().toIso8601String().substring(0, 10));

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      title: Row(children: [
        Icon(
          Icons.date_range_outlined,
          size: 33,
          color: DesktopColors.ceruleanOscure,
        ),
        const SizedBox(width: 10),
        Expanded(
            child: TextStyles.titleText(
          text: "Filtrar por fechas",
          color: DesktopColors.prussianBlue,
          size: 18,
        ))
      ]),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.standardText(
                    text: "Seleccione un periodo de tiempo:"),
                const SizedBox(height: 15),
                TextFormFieldCustom.textFormFieldwithBorderCalendar(
                  name: "Fecha inicial",
                  msgError: "",
                  esInvertido: true,
                  dateController: _initDateController,
                  onChanged: () => setState(
                    () => _endDateController.text =
                        Utility.getNextMonth(_initDateController.text),
                  ),
                ),
                TextFormFieldCustom.textFormFieldwithBorderCalendar(
                  name: "Fecha final",
                  msgError: "",
                  dateController: _endDateController,
                  fechaLimite: (_initDateController.text),
                )
              ],
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            funtionMain.call();
            Navigator.of(context)
                .pop(_initDateController.text + _endDateController.text);
          },
          child: TextStyles.buttonText(
            text: "Aceptar",
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextStyles.buttonText(text: "Cancelar")),
      ],
    );
  }
}
