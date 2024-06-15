import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/models/cotizacion_grupo_model.dart';
import 'package:generador_formato/widgets/custom_widgets.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:generador_formato/widgets/number_input_with_increment_decrement.dart';

import '../helpers/constants.dart';
import '../models/cotizacion_individual_model.dart';

class Dialogs {
  Widget habitacionIndividualDialog(
      {required BuildContext buildContext, CotizacionIndividual? cotizacion}) {
    CotizacionIndividual nuevaCotizacion = cotizacion ??
        CotizacionIndividual(
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
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      title: TextStyles.titleText(
          text: cotizacion != null ? "Editar habitación" : "Agregar habitación",
          color: WebColors.prussianBlue),
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
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 150,
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Numero de noches",
                          msgError: "Campo requerido*",
                          isNumeric: true,
                          isDecimal: false,
                          initialValue: cotizacion != null
                              ? nuevaCotizacion.noches!.toString()
                              : null,
                          onChanged: (p0) {
                            nuevaCotizacion.noches = int.tryParse(p0);
                          },
                        ),
                      ),
                    ],
                  ),
                  Table(
                    children: [
                      TableRow(children: [
                        TextStyles.standardText(
                            text: "Adultos", aling: TextAlign.center),
                        TextStyles.standardText(
                            text: "Menores 0-6", aling: TextAlign.center),
                        TextStyles.standardText(
                            text: "Menores 7-12", aling: TextAlign.center),
                      ]),
                      TableRow(children: [
                        NumberInputWithIncrementDecrement(
                          onChanged: (p0) {
                            nuevaCotizacion.adultos = int.tryParse(p0);
                          },
                          initialValue: cotizacion?.adultos!.toString(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: NumberInputWithIncrementDecrement(
                            onChanged: (p0) {
                              nuevaCotizacion.menores0a6 = int.tryParse(p0);
                            },
                            initialValue: cotizacion?.menores0a6!.toString(),
                          ),
                        ),
                        NumberInputWithIncrementDecrement(
                          onChanged: (p0) {
                            nuevaCotizacion.menores7a12 = int.tryParse(p0);
                          },
                          initialValue: cotizacion?.menores7a12!.toString(),
                        )
                      ]),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Tarifa real",
                          msgError: "Campo requerido*",
                          isNumeric: true,
                          isDecimal: true,
                          isMoneda: true,
                          initialValue: cotizacion != null
                              ? nuevaCotizacion.tarifaReal!.toString()
                              : null,
                          onChanged: (p0) {
                            nuevaCotizacion.tarifaReal = double.tryParse(p0);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Tarifa de preventa oferta por tiempo limitado",
                          msgError: "",
                          isRequired: false,
                          isNumeric: true,
                          isDecimal: true,
                          isMoneda: true,
                          initialValue: cotizacion != null
                              ? nuevaCotizacion.tarifaPreventa?.toString()
                              : null,
                          onChanged: (p0) {
                            nuevaCotizacion.tarifaPreventa =
                                double.tryParse(p0);
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

  Widget habitacionGrupoDialog(
      {required BuildContext buildContext, CotizacionGrupo? cotizacion}) {
    CotizacionGrupo nuevaCotizacion = cotizacion ??
        CotizacionGrupo(
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
          color: WebColors.prussianBlue),
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
                      SizedBox(
                        width: 150,
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Numero de noches",
                          msgError: "Campo requerido*",
                          isNumeric: true,
                          isDecimal: false,
                          initialValue: cotizacion != null
                              ? nuevaCotizacion.noches!.toString()
                              : null,
                          onChanged: (p0) {
                            nuevaCotizacion.noches = int.tryParse(p0);
                            _subtotalController.text = Utility.calculateTotal(
                              nuevaCotizacion.noches,
                              nuevaCotizacion.tarifaNoche,
                            );
                          },
                        ),
                      ),
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
                              nuevaCotizacion.noches,
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
}
