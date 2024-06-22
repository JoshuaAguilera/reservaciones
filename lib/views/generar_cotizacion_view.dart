import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/cotizacion_individual_provider.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/widgets/cotizacion_grupo_card.dart';
import 'package:generador_formato/widgets/cotizacion_indiv_card.dart';
import 'package:generador_formato/widgets/custom_widgets.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../helpers/constants.dart';
import '../models/cotizacion_grupo_model.dart';
import '../models/cotizacion_individual_model.dart';

class GenerarCotizacionView extends ConsumerStatefulWidget {
  final SidebarXController sideController;
  const GenerarCotizacionView({Key? key, required this.sideController})
      : super(key: key);

  @override
  GenerarCotizacionViewState createState() => GenerarCotizacionViewState();
}

class GenerarCotizacionViewState extends ConsumerState<GenerarCotizacionView> {
  String dropdownValue = cotizacionesList.first;
  List<CotizacionIndividual> cotizacionesInd = [];
  List<CotizacionGrupo> cotizacionesGrupo = [];
  final _formKeyCotizacion = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documentos = ref.watch(CotizacionIndividualProvider.provider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKeyCotizacion,
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
                  name: "Nombre completo",
                  msgError: "Campo requerido*",
                  isRequired: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Teléfono",
                        msgError: "Campo requerido*",
                        isNumeric: true,
                        isDecimal: false,
                        isRequired: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormFieldCustom.textFormFieldwithBorder(
                        name: "Correo electronico",
                        msgError: "Campo requerido*",
                        isRequired: true,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Divider(color: Colors.black54),
                ),
                TextStyles.titleText(text: "Cotizaciones"),
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
                            return (dropdownValue == "Cotización Individual")
                                ? Dialogs().habitacionIndividualDialog(
                                    buildContext: context)
                                : Dialogs().habitacionGrupoDialog(
                                    buildContext: context);
                          },
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              if (dropdownValue == "Cotización Individual") {
                                cotizacionesInd.add(value);
                              } else {
                                cotizacionesGrupo.add(value);
                              }
                            });
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 4,
                          backgroundColor: WebColors.prussianBlue),
                      child: Text(
                        "Agregar cotización",
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
                      columnWidths: {
                        0: const FractionColumnWidth(.05),
                        1: const FractionColumnWidth(.15),
                        2: const FractionColumnWidth(.1),
                        3: const FractionColumnWidth(.1),
                        4: const FractionColumnWidth(.1),
                        5: FractionColumnWidth(
                            (dropdownValue == "Cotización Individual")
                                ? .1
                                : 0.22),
                        6: FractionColumnWidth(
                            (dropdownValue == "Cotización Individual")
                                ? .21
                                : .1),
                      },
                      children: [
                        TableRow(children: [
                          TextStyles.standardText(
                              text: "#",
                              // (dropdownValue == "Cotización Individual")
                              //     ? "Día"
                              //     : "PAX",
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
                          if (dropdownValue == "Cotización Individual")
                            TextStyles.standardText(
                                text: "Menores 0-6",
                                aling: TextAlign.center,
                                overClip: true),
                          TextStyles.standardText(
                              text: "Menores 7-12",
                              aling: TextAlign.center,
                              overClip: true),
                          TextStyles.standardText(
                              text: (dropdownValue == "Cotización Individual")
                                  ? "Tarifa \nReal"
                                  : "Tarifa por noche",
                              aling: TextAlign.center,
                              overClip: true),
                          TextStyles.standardText(
                              text: (dropdownValue == "Cotización Individual")
                                  ? "Tarifa de preventa oferta por tiempo limitado"
                                  : "Habitaciones",
                              aling: TextAlign.center,
                              overClip: true),
                          if (dropdownValue == "Cotización Grupos")
                            TextStyles.standardText(
                                text: "Subtotal",
                                aling: TextAlign.center,
                                overClip: true),
                          const SizedBox(width: 15)
                        ]),
                      ],
                    ),
                  ),
                const Divider(color: Colors.black54),
                if (dropdownValue == "Cotización Individual")
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      height: limitHeightList(cotizacionesInd.length),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: cotizacionesInd.length,
                        itemBuilder: (context, index) {
                          if (index < cotizacionesInd.length) {
                            return CotizacionIndividualCard(
                              key: ObjectKey(cotizacionesInd[index].hashCode),
                              index: index,
                              cotizacion: cotizacionesInd[index],
                              compact:
                                  !isResizable(widget.sideController.extended),
                              onPressedDelete: () => setState(() =>
                                  cotizacionesInd
                                      .remove(cotizacionesInd[index])),
                              onPressedEdit: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialogs().habitacionIndividualDialog(
                                        buildContext: context,
                                        cotizacion: cotizacionesInd[index]);
                                  },
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      cotizacionesInd[index] = value;
                                    });
                                  }
                                });
                              },
                            );
                          }
                        },
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      height: limitHeightList(cotizacionesGrupo.length),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: cotizacionesGrupo.length,
                        itemBuilder: (context, index) {
                          if (index < cotizacionesGrupo.length) {
                            return CotizacionGrupoCard(
                              key: ObjectKey(cotizacionesGrupo[index].hashCode),
                              index: index,
                              cotizacion: cotizacionesGrupo[index],
                              compact:
                                  !isResizable(widget.sideController.extended),
                              onPressedDelete: () => setState(() =>
                                  cotizacionesGrupo
                                      .remove(cotizacionesGrupo[index])),
                              onPressedEdit: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialogs().habitacionGrupoDialog(
                                        buildContext: context,
                                        cotizacion: cotizacionesGrupo[index]);
                                  },
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      cotizacionesGrupo[index] = value;
                                    });
                                  }
                                });
                              },
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
                      onPressed: () async {
                        if (_formKeyCotizacion.currentState!.validate()) {
                          if((cotizacionesInd.isEmpty && dropdownValue == "Cotización Individual") || (cotizacionesGrupo.isEmpty &&  dropdownValue == "Cotización Grupos")) {
                            showSnackBar(context, "Se requiere al menos una cotización");
                            return null;
                          }
                          pw.Document comprobante = await ref
                              .watch(CotizacionIndividualProvider
                                  .provider.notifier)
                              .generarComprobante();

                          await Printing.sharePdf(
                            bytes: await comprobante.save(),
                            filename: "cotizacion.pdf",
                            emails: ["fabioball230@gmail.com"],
                          );

                          // await Printing.layoutPdf(
                          //     name: "example",
                          //     format: PdfPageFormat.a4,
                          //     onLayout: (format) async => comprobante.save());
                        }
                      },
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
      height = 290;
    }
    return height;
  }
}
