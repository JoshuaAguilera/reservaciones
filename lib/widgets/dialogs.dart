import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/widgets/custom_widgets.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:generador_formato/widgets/number_input_with_increment_decrement.dart';

import '../models/cotizacion_model.dart';

const List<String> categorias = <String>[
  'HABITACIÓN DELUXE DOBLE',
  'HABITACIÓN DELUXE DOBLE O KING SIZE',
];

const List<String> planes = <String>[
  'PLAN TODO INCLUIDO',
  'SOLO HOSPEDAJE',
];

class Dialogs {
  Widget habitacionDialog(BuildContext context) {
    Cotizacion nuevaCotizacion = Cotizacion(
      categoria: categorias.first,
      plan: planes.first,
      fechaEntrada: DateTime.now().toString().substring(0, 10),
      adultos: 0,
      menores0a6: 0,
      menores7a12: 0,
    );
    final _formKeyHabitacion = GlobalKey<FormState>();
    TextEditingController _fechaEntrada =
        TextEditingController(text: DateTime.now().toString().substring(0, 10));
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      title: TextStyles.titleText(
          text: "Agregar habitación", color: WebColors.prussianBlue),
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
                      TextStyles.standardText(text: "Categoría: "),
                      const SizedBox(width: 15),
                      CustomWidgets.dropdownMenuCustom(
                          initialSelection: categorias.first,
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
                      TextStyles.standardText(text: "Plan: "),
                      const SizedBox(width: 15),
                      CustomWidgets.dropdownMenuCustom(
                          initialSelection: planes.first,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: NumberInputWithIncrementDecrement(
                            onChanged: (p0) {
                              nuevaCotizacion.menores0a6 = int.tryParse(p0);
                            },
                          ),
                        ),
                        NumberInputWithIncrementDecrement(
                          onChanged: (p0) {
                            nuevaCotizacion.menores7a12 = int.tryParse(p0);
                          },
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
                Navigator.of(context).pop(nuevaCotizacion);
              }
            },
            child: TextStyles.buttonText(text: "Agregar")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextStyles.buttonText(text: "Cancelar"))
      ],
    );
  }
}
