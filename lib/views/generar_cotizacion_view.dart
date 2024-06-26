import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/helpers/utility.dart';
import 'package:generador_formato/providers/comprobante_provider.dart';
import 'package:generador_formato/providers/cotizacion_individual_provider.dart';
import 'package:generador_formato/services/comprobante_service.dart';
import 'package:generador_formato/ui/progress_indicator.dart';
import 'package:generador_formato/ui/show_snackbar.dart';
import 'package:generador_formato/widgets/cotizacion_indiv_card.dart';
import 'package:generador_formato/widgets/custom_widgets.dart';
import 'package:generador_formato/widgets/dialogs.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:generador_formato/widgets/textformfield_custom.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../helpers/constants.dart';

class GenerarCotizacionView extends ConsumerStatefulWidget {
  final SidebarXController sideController;
  const GenerarCotizacionView({Key? key, required this.sideController})
      : super(key: key);

  @override
  GenerarCotizacionViewState createState() => GenerarCotizacionViewState();
}

class GenerarCotizacionViewState extends ConsumerState<GenerarCotizacionView> {
  String dropdownValue = cotizacionesList.first;
  final _formKeyCotizacion = GlobalKey<FormState>();
  late pw.Document comprobantePDF;
  bool isLoading = false;
  bool isFinish = false;

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
    double screenHight = MediaQuery.of(context).size.height;
    final cotizaciones = ref.watch(CotizacionIndividualProvider.provider);
    final comprobante = ref.watch(comprobanteProvider);
    final folio = ref.watch(uniqueFolioProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKeyCotizacion,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextStyles.titlePagText(text: "Generar cotización"),
                        if (isFinish)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isFinish = false;
                                isLoading = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 4,
                                backgroundColor: WebColors.prussianBlue),
                            child: (!Utility.isResizable(
                                    extended: widget.sideController.extended,
                                    context: context,
                                    minWidth: 425,
                                    minWidthWithBar: 435))
                                ? TextStyles.buttonTextStyle(
                                    text: "Nueva cotizacion")
                                : const Icon(
                                    Icons.restore_page,
                                    color: Colors.white,
                                  ),
                          )
                      ],
                    ),
                    const Divider(color: Colors.black54),
                    if (!isLoading)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            initialValue: comprobante.nombre,
                            isRequired: true,
                            onChanged: (p0) {
                              comprobante.nombre = p0;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child:
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                  name: "Teléfono",
                                  msgError: "Campo requerido*",
                                  initialValue: comprobante.telefono,
                                  isNumeric: true,
                                  isDecimal: false,
                                  isRequired: true,
                                  onChanged: (p0) {
                                    comprobante.telefono = p0;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child:
                                    TextFormFieldCustom.textFormFieldwithBorder(
                                  name: "Correo electronico",
                                  msgError: "Campo requerido*",
                                  initialValue: comprobante.correo,
                                  isRequired: true,
                                  onChanged: (p0) {
                                    comprobante.correo = p0;
                                  },
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
                                      return (dropdownValue ==
                                              "Cotización Individual")
                                          ? Dialogs()
                                              .habitacionIndividualDialog(
                                                  buildContext: context)
                                          : Dialogs().habitacionGrupoDialog(
                                              buildContext: context);
                                    },
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() => cotizaciones.add(value));
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
                          if (!Utility.isResizable(
                              extended: widget.sideController.extended,
                              context: context))
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
                                    if (dropdownValue ==
                                        "Cotización Individual")
                                      TextStyles.standardText(
                                          text: "Menores 0-6",
                                          aling: TextAlign.center,
                                          overClip: true),
                                    TextStyles.standardText(
                                        text: "Menores 7-12",
                                        aling: TextAlign.center,
                                        overClip: true),
                                    TextStyles.standardText(
                                        text: (dropdownValue ==
                                                "Cotización Individual")
                                            ? "Tarifa \nReal"
                                            : "Tarifa por noche",
                                        aling: TextAlign.center,
                                        overClip: true),
                                    TextStyles.standardText(
                                        text: (dropdownValue ==
                                                "Cotización Individual")
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
                                    return CotizacionIndividualCard(
                                      key: ObjectKey(
                                          cotizaciones[index].hashCode),
                                      index: index,
                                      cotizacion: cotizaciones[index],
                                      compact: !Utility.isResizable(
                                          extended:
                                              widget.sideController.extended,
                                          context: context),
                                      onPressedDelete: () => setState(() =>
                                          cotizaciones
                                              .remove(cotizaciones[index])),
                                      onPressedEdit: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialogs()
                                                .habitacionIndividualDialog(
                                                    buildContext: context,
                                                    cotizacion:
                                                        cotizaciones[index]);
                                          },
                                        ).then((value) {
                                          if (value != null) {
                                            setState(() {
                                              cotizaciones[index] = value;
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
                                  if (_formKeyCotizacion.currentState!
                                      .validate()) {
                                    if (cotizaciones.isEmpty) {
                                      showSnackBar(
                                        context: context,
                                        title: "Cotizaciones no registradas",
                                        message:
                                            "Se requiere al menos una cotización",
                                      );
                                      return;
                                    }

                                    setState(() => isLoading = true);

                                    if (await ComprobanteService()
                                        .createComprobante(comprobante,
                                            cotizaciones, folio)) {}

                                    comprobantePDF = await ref
                                        .watch(CotizacionIndividualProvider
                                            .provider.notifier)
                                        .generarComprobante(comprobante);

                                    Future.delayed(
                                        Durations.extralong1,
                                        () => setState(() {
                                              isFinish = true;
                                              comprobante.correo = "";
                                              comprobante.nombre = "";
                                              comprobante.telefono = "";
                                              cotizaciones.clear();
                                            }));
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
                    if (isLoading && !isFinish)
                      ProgressIndicatorCustom(screenHight),
                    if (isFinish)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SizedBox(
                          height: screenHight * 0.89,
                          child: PdfPreview(
                            build: (format) => comprobantePDF.save(),
                            actionBarTheme: PdfActionBarTheme(
                              backgroundColor: WebColors.ceruleanOscure,
                            ),
                            canChangeOrientation: false,
                            canChangePageFormat: false,
                            canDebug: false,
                            allowSharing: false,
                            pdfFileName:
                                "Comprobante de cotizacion ${DateTime.now().toString().substring(0, 10)}.pdf",
                            actions: [
                              IconButton(
                                  onPressed: () async {
                                    await Printing.sharePdf(
                                      filename:
                                          "Comprobante de cotizacion ${DateTime.now().toString().substring(0, 10)}.pdf",
                                      bytes: await comprobantePDF.save(),
                                    );
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.arrow_down_doc_fill,
                                    color: Colors.white,
                                    size: 22,
                                  ))
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double? limitHeightList(int length) {
    double? height;
    if (length > 3) {
      height = 290;
    }
    return height;
  }
}
