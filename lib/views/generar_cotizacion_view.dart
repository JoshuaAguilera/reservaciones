import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/widgets/cotizacion_listtile.dart';
import 'package:generador_formato/widgets/custom_widgets.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../models/cotizacion_model.dart';

const List<String> cotizacionesList = <String>[
  'Cotización Individual',
  'Cotización Grupos',
  'Cotización Grupos - Temporada Baja',
];

class GenerarCotizacionView extends StatefulWidget {
  final SidebarXController sideController;
  const GenerarCotizacionView({Key? key, required this.sideController})
      : super(key: key);

  @override
  State<GenerarCotizacionView> createState() => _GenerarCotizacionViewState();
}

class _GenerarCotizacionViewState extends State<GenerarCotizacionView> {
  String dropdownValue = cotizacionesList.first;
  List<Cotizacion> cotizaciones = [];

  @override
  void dispose() {
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
              TextStyles.titlePagText(text: "Generar Cotización"),
              const Divider(color: Colors.black54),
              Align(
                alignment: Alignment.centerRight,
                child: CustomWidgets.dropdownMenuCustom(
                    initialSelection: cotizacionesList.first,
                    onSelected: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    elements: cotizacionesList,
                    screenWidth: null),
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
              if (!isResizable(widget.sideController.extended))
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Table(
                    columnWidths: const {
                      0: FractionColumnWidth(.05),
                      1: FractionColumnWidth(.15),
                      2: FractionColumnWidth(.1),
                      3: FractionColumnWidth(.1),
                      4: FractionColumnWidth(.1),
                      5: FractionColumnWidth(.1),
                      6: FractionColumnWidth(.21),
                    },
                    children: [
                      TableRow(children: [
                        TextStyles.standardText(
                            text: "Día",
                            aling: TextAlign.center,
                            overClip: true),
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
                            text:
                                "Tarifa de preventa oferta por tiempo limitado",
                            aling: TextAlign.center,
                            overClip: true),
                        const SizedBox(width: 15)
                      ]),
                    ],
                  ),
                ),
              const Divider(color: Colors.black54),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: limitHeightList(cotizaciones.length),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: cotizaciones.length,
                    itemBuilder: (context, index) {
                      if (index < cotizaciones.length) {
                        return CotizacionListtile(
                          index: index,
                          cotizacion: cotizaciones[index],
                          compact: !isResizable(widget.sideController.extended),
                          onPressedDelete: () {
                            setState(
                                () => cotizaciones.remove(cotizaciones[index]));
                          },
                          onPressedEdit: () {},
                        );
                      }
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 12, top: 8),
                child: Divider(color: Colors.black54),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 4,
                        backgroundColor: WebColors.ceruleanOscure),
                    child: Text(
                      "Generar cotización",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isResizable(bool extended) {
    bool isVisible = true;
    final isSmallScreen = MediaQuery.of(context).size.width < 700;
    final isSmallScreenWithSideBar = MediaQuery.of(context).size.width < 725;
    isVisible = (extended) ? isSmallScreenWithSideBar : isSmallScreen;
    return isVisible;
  }

  double? limitHeightList(int length) {
    double? height;
    if (length > 3) {
      height = 300;
    }
    return height;
  }
}
