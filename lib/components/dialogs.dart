import 'package:flutter/material.dart';
import 'package:generador_formato/widgets/custom_widgets.dart';
import 'package:generador_formato/components/text_styles.dart';
import 'package:generador_formato/components/textformfield_custom.dart';
import 'package:generador_formato/constants/web_colors.dart';
import 'package:generador_formato/widgets/number_input_with_increment_decrement.dart';

const List<String> categorias = <String>[
  'HABITACIÓN DELUXE DOBLE',
  'HABITACIÓN DELUXE DOBLE O KING SIZE',
];

const List<String> planes = <String>[
  'PLAN TODO INCLUIDO',
  'SOLO HOSPEDAJE',
];

class Dialogs {
  String dropdownCategoria = categorias.first;
  String dropdownPlan = planes.first;
  Widget habitacionDialog() {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      title: TextStyles.titleText(
          text: "Agregar habitación", color: WebColors.prussianBlue),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextStyles.standardText(text: "Categoría: "),
                      const SizedBox(width: 15),
                      CustomWidgets.dropdownMenuCustom(
                          initialSelection: categorias.first,
                          changeValue: dropdownCategoria,
                          elements: categorias),
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
                          changeValue: dropdownPlan,
                          elements: planes),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 340,
                        child:
                            TextFormFieldCustom.textFormFieldwithBorderCalendar(
                                name: "Fecha de entrada",
                                msgError: "Campo requerido*"),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 150,
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                          name: "Numero de noches",
                          msgError: "Campo requerido*",
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
                      const TableRow(children: [
                        NumberInputWithIncrementDecrement(),
                        NumberInputWithIncrementDecrement(),
                        NumberInputWithIncrementDecrement()
                      ]),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child:
                            TextFormFieldCustom.textFormFieldwithBorder(
                                name: "Tarifa real",
                                msgError: "Campo requerido*"),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormFieldCustom.textFormFieldwithBorder(
                            name:
                                "Tarifa de preventa oferta por tiempo limitado",
                            msgError: ""),
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
            onPressed: () {}, child: TextStyles.buttonText(text: "Agregar")),
        TextButton(
            onPressed: () {}, child: TextStyles.buttonText(text: "Cancelar"))
      ],
    );
  }
}
