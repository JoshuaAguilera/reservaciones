import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/comprobante_provider.dart';
import 'package:printing/printing.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import '../helpers/utility.dart';
import '../helpers/web_colors.dart';
import '../services/generador_doc_service.dart';
import '../ui/progress_indicator.dart';
import '../widgets/cotizacion_indiv_card.dart';
import '../widgets/text_styles.dart';

class ComprobanteDetalleView extends ConsumerStatefulWidget {
  const ComprobanteDetalleView({super.key, required this.sideController});

  final SidebarXController sideController;
  @override
  _ComprobanteDetalleViewState createState() => _ComprobanteDetalleViewState();
}

class _ComprobanteDetalleViewState
    extends ConsumerState<ComprobanteDetalleView> {
  late pw.Document comprobantePDF;
  bool isLoading = false;
  bool isFinish = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final comprobante = ref.watch(comprobanteDetalleProvider);
    double screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        if (!isFinish) {
                          widget.sideController.selectIndex(2);
                        } else {
                          isFinish = false;
                          isLoading = false;
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        CupertinoIcons.chevron_left_circle,
                        color: WebColors.prussianBlue,
                        size: 30,
                      )),
                  Expanded(
                    child: TextStyles.titlePagText(
                      text:
                          "Detalles de cotización - ${comprobante.folioCuotas}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.black54),
              if (!isLoading)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextStyles.titleText(text: "")),
                    const SizedBox(height: 15),
                    TextStyles.titleText(text: "Datos del huesped"),
                    const SizedBox(height: 0),
                    Card(
                      elevation: 7,
                      color: Colors.blue[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextStyles.standardText(
                                text: "Nombre: ${comprobante.nombre!}"),
                            TextStyles.standardText(
                                text:
                                    "Correo electronico: ${comprobante.correo!}"),
                            TextStyles.standardText(
                                text: "Telefono: ${comprobante.telefono!}"),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Divider(color: Colors.black54),
                    ),
                    TextStyles.titleText(text: "Cotizaciones"),
                    const SizedBox(height: 12),
                    if (!Utility.isResizable(
                        extended: widget.sideController.extended,
                        context: context))
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
                              // if (dropdownValue == "Cotización Individual")
                              TextStyles.standardText(
                                  text: "Menores 0-6",
                                  aling: TextAlign.center,
                                  overClip: true),
                              TextStyles.standardText(
                                  text: "Menores 7-12",
                                  aling: TextAlign.center,
                                  overClip: true),
                              TextStyles.standardText(
                                  text: "Tarifa por noche",
                                  aling: TextAlign.center,
                                  overClip: true),
                              TextStyles.standardText(
                                  text:
                                      "Tarifa de preventa oferta por tiempo limitado",
                                  aling: TextAlign.center,
                                  overClip: true),
                              // if (dropdownValue == "Cotización Grupos")
                              //   TextStyles.standardText(
                              //       text: "Subtotal",
                              //       aling: TextAlign.center,
                              //       overClip: true),
                            ]),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        height: Utility.limitHeightList(
                            comprobante.cotizaciones!.length),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: comprobante.cotizaciones!.length,
                          itemBuilder: (context, index) {
                            if (index < comprobante.cotizaciones!.length) {
                              return CotizacionIndividualCard(
                                key: ObjectKey(
                                    comprobante.cotizaciones![index].hashCode),
                                index: index,
                                cotizacion: comprobante.cotizaciones![index],
                                compact: !Utility.isResizable(
                                    extended: widget.sideController.extended,
                                    context: context),
                                esDetalle: true,
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
                        width: 230,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() => isLoading = true);

                            comprobantePDF = await GeneradorDocService()
                                .generarComprobanteCotizacion(
                                    comprobante.cotizaciones!, comprobante);

                            Future.delayed(
                              Durations.long2,
                              () => setState(() => isFinish = true),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 4,
                              backgroundColor: WebColors.ceruleanOscure),
                          child: TextStyles.buttonTextStyle(
                              text: "Generar comprobante PDF"),
                        ),
                      ),
                    ),
                  ],
                ),
              if (isLoading && !isFinish) ProgressIndicatorCustom(screenHight),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
