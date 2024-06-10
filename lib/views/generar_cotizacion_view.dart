import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/components/dialogs.dart';
import 'package:generador_formato/components/text_styles.dart';
import 'package:generador_formato/components/textformfield_custom.dart';
import 'package:generador_formato/components/utility.dart';
import 'package:generador_formato/constants/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/cotizacion_model.dart';

const List<String> list = <String>[
  'Cotización Individual',
  'Cotización Grupos',
  'Cotización Grupos - Temporada Baja',
];

class GenerarCotizacionView extends StatefulWidget {
  const GenerarCotizacionView({Key? key}) : super(key: key);

  @override
  State<GenerarCotizacionView> createState() => _GenerarCotizacionViewState();
}

class _GenerarCotizacionViewState extends State<GenerarCotizacionView> {
  String dropdownValue = list.first;
  List<Cotizacion> cotizaciones = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Generar Cotización",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: WebColors.prussianBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const Divider(color: Colors.black54),
              Align(
                alignment: Alignment.centerRight,
                child: DropdownMenu<String>(
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  textStyle: GoogleFonts.poppins(fontSize: 13),
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                        style: ButtonStyle(
                            textStyle: WidgetStatePropertyAll(
                                GoogleFonts.poppins(fontSize: 13))));
                  }).toList(),
                ),
              ),
              const SizedBox(height: 15),
              TextStyles.titleText(text: "Datos del cliente"),
              const SizedBox(height: 15),
              TextFormFieldCustom.textFormFieldwithBorder(
                  name: "Nombre completo", msgError: "Campo requerido*"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Teléfono",
                        msgError: "Campo requerido*",
                        isNumeric: true,
                        isDecimal: false),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Correo electronico",
                        msgError: "Campo requerido*"),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Fecha de entrada:",
                        msgError: "Campo requerido*"),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Numero de noches",
                        msgError: "Campo requerido*",
                        isNumeric: true,
                        isDecimal: false),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: Colors.black54),
              ),
              TextStyles.titleText(text: "Habitaciones"),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialogs().habitacionDialog(context);
                        },
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            cotizaciones.add(value);
                          });
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 4, backgroundColor: WebColors.prussianBlue),
                    child: Text(
                      "Agregar habitación",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: WebColors.prussianBlue),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  columnWidths: const {
                    0: FractionColumnWidth(.05),
                    1: FractionColumnWidth(.15),
                    2: FractionColumnWidth(.1),
                    3: FractionColumnWidth(.1),
                    4: FractionColumnWidth(.1),
                    5: FractionColumnWidth(.15),
                    6: FractionColumnWidth(.25),
                  },
                  border: const TableBorder(
                      horizontalInside: BorderSide(color: Colors.black87)),
                  children: [
                    TableRow(children: [
                      TextStyles.standardText(
                          text: "Día", aling: TextAlign.center, overClip: true),
                      TextStyles.standardText(
                          text: "Fechas de estancia",
                          aling: TextAlign.center,
                          overClip: true),
                      TextStyles.standardText(
                          text: "Adultos",
                          aling: TextAlign.center,
                          overClip: true),
                      TextStyles.standardText(
                          text: "Menores 0-6",
                          aling: TextAlign.center,
                          overClip: true),
                      TextStyles.standardText(
                          text: "Menores 7-12",
                          aling: TextAlign.center,
                          overClip: true),
                      TextStyles.standardText(
                          text: "Tarifa \nReal",
                          aling: TextAlign.center,
                          overClip: true),
                      TextStyles.standardText(
                          text: "Tarifa de preventa oferta por tiempo limitado",
                          aling: TextAlign.center,
                          overClip: true),
                      const SizedBox(
                        width: 15,
                      )
                    ]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 5),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: cotizaciones.length,
                  itemBuilder: (context, index) {
                    if (index < cotizaciones.length) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: WebColors.prussianBlue),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        padding: const EdgeInsets.all(10.0),
                        child: Table(
                          columnWidths: const {
                            0: FractionColumnWidth(.05),
                            1: FractionColumnWidth(.15),
                            2: FractionColumnWidth(.1),
                            3: FractionColumnWidth(.1),
                            4: FractionColumnWidth(.1),
                            5: FractionColumnWidth(.15),
                            6: FractionColumnWidth(.25),
                          },
                          border: const TableBorder(
                              horizontalInside:
                                  BorderSide(color: Colors.black87)),
                          children: [
                            TableRow(children: [
                              TextStyles.standardText(
                                text: (index + 1).toString(),
                                aling: TextAlign.center,
                                overClip: true,
                              ),
                              TextStyles.standardText(
                                text: Utility.getLengthStay(
                                    cotizaciones[index].fechaEntrada,
                                    cotizaciones[index].noches),
                                aling: TextAlign.center,
                                overClip: true,
                              ),
                              TextStyles.standardText(
                                  text: cotizaciones[index].adultos.toString(),
                                  aling: TextAlign.center,
                                  overClip: true),
                              TextStyles.standardText(
                                  text:
                                      cotizaciones[index].menores0a6.toString(),
                                  aling: TextAlign.center,
                                  overClip: true),
                              TextStyles.standardText(
                                  text: cotizaciones[index]
                                      .menores7a12
                                      .toString(),
                                  aling: TextAlign.center,
                                  overClip: true),
                              TextStyles.standardText(
                                  text: "\$ ${cotizaciones[index].tarifaReal}",
                                  aling: TextAlign.center,
                                  overClip: true),
                              TextStyles.standardText(
                                  text:
                                      "\$ ${(cotizaciones[index].tarifaPreventa != null) ? cotizaciones[index].tarifaPreventa : cotizaciones[index].tarifaReal}",
                                  aling: TextAlign.center,
                                  overClip: true),
                              const SizedBox(
                                width: 15,
                              )
                            ]),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
