import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/comprobante_provider.dart';
import 'package:generador_formato/widgets/cotizacion_grupo_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:printing/printing.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../utils/helpers/utility.dart';
import '../../utils/helpers/web_colors.dart';
import '../../services/generador_doc_service.dart';
import '../../ui/progress_indicator.dart';
import '../../widgets/cotizacion_indiv_card.dart';
import '../../widgets/text_styles.dart';

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
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      )),
                  Expanded(
                    child: TextStyles.titlePagText(
                      text:
                          "Detalles de cotización - ${comprobante.folioCuotas}",
                      overflow: TextOverflow.ellipsis,
                      color: Theme.of(context).primaryColor,
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
                            TextStyles.TextAsociative(
                                "Nombre: ", comprobante.nombre!,
                                size: 13),
                            TextStyles.TextAsociative(
                                "Correo electronico: ", comprobante.correo!,
                                size: 13),
                            TextStyles.TextAsociative(
                                "Telefono: ", comprobante.telefono!,
                                size: 13),
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Table(
                            columnWidths: {
                              0: FractionColumnWidth(
                                  (!comprobante.esGrupal!) ? .05 : .18),
                              1: FractionColumnWidth(
                                  (!comprobante.esGrupal!) ? .15 : 0.22),
                              2: const FractionColumnWidth(0.09),
                              3: FractionColumnWidth(
                                  (!comprobante.esGrupal!) ? .1 : 0.22),
                              4: const FractionColumnWidth(.1),
                              5: FractionColumnWidth(
                                  (!comprobante.esGrupal!) ? .1 : 0.15),
                            },
                            children: [
                              TableRow(children: [
                                if (!comprobante.esGrupal!)
                                  TextStyles.standardText(
                                      text: "#",
                                      aling: TextAlign.center,
                                      color: Theme.of(context).primaryColor,
                                      overClip: true),
                                TextStyles.standardText(
                                    text: "Fechas de estancia",
                                    aling: TextAlign.center,
                                    color: Theme.of(context).primaryColor,
                                    overClip: true),
                                if (!comprobante.esGrupal!)
                                  TextStyles.standardText(
                                      text: "Adultos",
                                      aling: TextAlign.center,
                                      color: Theme.of(context).primaryColor,
                                      overClip: true),
                                if (!comprobante.esGrupal!)
                                  TextStyles.standardText(
                                      text: "Menores 0-6",
                                      aling: TextAlign.center,
                                      color: Theme.of(context).primaryColor,
                                      overClip: true),
                                TextStyles.standardText(
                                    text: (!comprobante.esGrupal!)
                                        ? "Menores 7-12"
                                        : "1 o 2 Adultos",
                                    aling: TextAlign.center,
                                    color: Theme.of(context).primaryColor,
                                    overClip: true),
                                TextStyles.standardText(
                                    text: (!comprobante.esGrupal!)
                                        ? "Tarifa \nReal"
                                        : "3 Adultos",
                                    aling: TextAlign.center,
                                    color: Theme.of(context).primaryColor,
                                    overClip: true),
                                if (comprobante.esGrupal!)
                                  TextStyles.standardText(
                                      text: "  4 Adultos  ",
                                      aling: TextAlign.center,
                                      color: Theme.of(context).primaryColor,
                                      overClip: true),
                                if (comprobante.esGrupal!)
                                  TextStyles.standardText(
                                      text: "Menores 7 a 12 Años",
                                      color: Theme.of(context).primaryColor,
                                      aling: TextAlign.center,
                                      overClip: true),
                                if (!comprobante.esGrupal!)
                                  TextStyles.standardText(
                                      text:
                                          "Tarifa de preventa oferta por tiempo limitado",
                                      color: Theme.of(context).primaryColor,
                                      aling: TextAlign.center,
                                      overClip: true),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    if (!comprobante.esGrupal!)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          height: Utility.limitHeightList(
                              comprobante.cotizacionesInd!.length),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: comprobante.cotizacionesInd!.length,
                            itemBuilder: (context, index) {
                              if (index < comprobante.cotizacionesInd!.length) {
                                return CotizacionIndividualCard(
                                  key: ObjectKey(comprobante
                                      .cotizacionesInd![index].hashCode),
                                  index: index,
                                  cotizacion:
                                      comprobante.cotizacionesInd![index],
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
                    if (comprobante.esGrupal!)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          height: Utility.limitHeightList(
                              comprobante.cotizacionesGrup!.length),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: comprobante.cotizacionesGrup!.length,
                            itemBuilder: (context, index) {
                              if (index <
                                  comprobante.cotizacionesGrup!.length) {
                                return CotizacionGrupoCard(
                                  key: ObjectKey(comprobante
                                      .cotizacionesGrup![index].hashCode),
                                  index: index,
                                  cotGroup:
                                      comprobante.cotizacionesGrup![index],
                                  compact: !Utility.isResizable(
                                      extended: widget.sideController.extended,
                                      context: context),
                                  isDetail: true,
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

                            if (comprobante.esGrupal!) {
                              comprobantePDF = await GeneradorDocService()
                                  .generarComprobanteCotizacionGrupal(
                                      comprobante.cotizacionesGrup!,
                                      comprobante);
                            } else {
                              comprobantePDF = await GeneradorDocService()
                                  .generarComprobanteCotizacionIndividual(
                                      cotizacionesInd:
                                          comprobante.cotizacionesInd!,
                                      comprobante: comprobante);
                            }

                            Future.delayed(
                              Durations.long2,
                              () => setState(() => isFinish = true),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 4,
                              backgroundColor: DesktopColors.ceruleanOscure),
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
                        backgroundColor: DesktopColors.ceruleanOscure,
                        iconColor: Theme.of(context).primaryColor,
                      ),
                      canChangeOrientation: false,
                      canChangePageFormat: false,
                      canDebug: false,
                      allowSharing: false,
                      loadingWidget: Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: Colors.grey,
                          size: 45,
                        ),
                      ),
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
                          icon: Icon(
                            CupertinoIcons.arrow_down_doc_fill,
                            color: Theme.of(context).primaryColor,
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
