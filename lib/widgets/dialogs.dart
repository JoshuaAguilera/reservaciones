import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/cotizacion_grupal_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/custom_dropdown.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/utils/helpers/web_colors.dart';
import 'package:generador_formato/widgets/number_input_with_increment_decrement.dart';

import '../utils/helpers/constants.dart';
import '../models/cotizacion_model.dart';

class Dialogs {
  Widget habitacionIndividualDialog(
      {required BuildContext buildContext, Cotizacion? cotizacion, void Function(Cotizacion?)? onInsert}) {
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
    bool esOferta = cotizacion != null ? cotizacion.esPreVenta! : false;
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
                    CustomDropdown.dropdownMenuCustom(
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
                    CustomDropdown.dropdownMenuCustom(
                      initialSelection:
                          cotizacion != null ? cotizacion.plan! : planes.first,
                      onSelected: (String? value) {
                        nuevaCotizacion.plan = value!;
                      },
                      elements: planes,
                      screenWidth: MediaQuery.of(context).size.width,
                      removeItem: "PLAN SIN ALIMENTOS",
                    ),
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
                        fechaLimite: DateTime.now()
                            .subtract(const Duration(days: 1))
                            .toIso8601String()
                            .substring(0, 10),
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
            child: TextStyles.buttonText(text: "Cancelar"),
          ),
        ],
      );
    });
  }

  Widget habitacionGrupoDialog(
      {required BuildContext buildContext, CotizacionGrupal? cotizacion}) {
    //data Quote
    String type = tipoHabitacion.first;
    String plan = planes.first;

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
    TextEditingController _habitacionController = TextEditingController();
    TextEditingController _adults1_2Controller = TextEditingController();
    TextEditingController _adults3Controller = TextEditingController();
    TextEditingController _adults4Controller = TextEditingController();
    TextEditingController _minors7_12Controller = TextEditingController();

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
                      CustomDropdown.dropdownMenuCustom(
                          initialSelection:
                              cotizacion != null ? cotizacion.categoria! : type,
                          onSelected: (String? value) {
                            type = value!;
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
                      CustomDropdown.dropdownMenuCustom(
                        initialSelection:
                            cotizacion != null ? cotizacion.plan! : plan,
                        onSelected: (String? value) {
                          plan = value!;
                        },
                        elements: planes,
                        screenWidth: MediaQuery.of(context).size.width,
                        removeItem: "SOLO HOSPEDAJE",
                      ),
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
                          fechaLimite: DateTime.now()
                              .subtract(const Duration(days: 1))
                              .toIso8601String()
                              .substring(0, 10),
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
                  Row(
                    children: [
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                            name: "Numero de habitaciones",
                            isNumeric: true,
                            isDecimal: true,
                            controller: _habitacionController,
                            icon: Icon(
                              CupertinoIcons.bed_double_fill,
                              color: DesktopColors.ceruleanOscure,
                            )),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextStyles.titleText(
                        text: "Tarífas:",
                        size: 15,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "1 O 2 ADULTOS",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          controller: _adults1_2Controller,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "3 ADULTOS",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          controller: _adults3Controller,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "4 ADULTO",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          controller: _adults4Controller,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormWidgets.textFormFieldResizable(
                          name: "MENORES 7 A 12 AÑOS",
                          isDecimal: true,
                          isNumeric: true,
                          isMoneda: true,
                          controller: _minors7_12Controller,
                        ),
                      ),
                    ],
                  ),
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
                Navigator.of(buildContext).pop();
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

  static AlertDialog customAlertDialog({
    IconData? iconData,
    Color? iconColor,
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
            color: iconColor ?? DesktopColors.ceruleanOscure,
          ),
        const SizedBox(width: 10),
        Expanded(child: TextStyles.titleText(text: title, size: 18))
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
