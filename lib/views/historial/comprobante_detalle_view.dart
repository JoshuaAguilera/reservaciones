import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/cotizacion_provider.dart';
import 'package:generador_formato/widgets/habitacion_item_row.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:printing/printing.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../utils/helpers/utility.dart';
import '../../utils/helpers/web_colors.dart';
import '../../services/generador_doc_service.dart';
import '../../ui/progress_indicator.dart';
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
    final cotizacion = ref.watch(cotizacionDetalleProvider);
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
                          "Detalles de cotización - ${cotizacion.folioPrincipal}",
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
                                "Nombre: ", cotizacion.nombreHuesped!,
                                size: 13),
                            TextStyles.TextAsociative("Correo electronico: ",
                                cotizacion.correoElectronico!,
                                size: 13),
                            TextStyles.TextAsociative(
                                "Telefono: ", cotizacion.numeroTelefonico!,
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
                                  (!cotizacion.esGrupo!) ? .05 : .18),
                              1: FractionColumnWidth(
                                  (!cotizacion.esGrupo!) ? .15 : 0.22),
                              2: const FractionColumnWidth(0.09),
                              3: FractionColumnWidth(
                                  (!cotizacion.esGrupo!) ? .1 : 0.22),
                              4: const FractionColumnWidth(.1),
                              5: FractionColumnWidth(
                                  (!cotizacion.esGrupo!) ? .1 : 0.15),
                            },
                            children: [
                              TableRow(children: [
                                if (!cotizacion.esGrupo!)
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
                                if (!cotizacion.esGrupo!)
                                  TextStyles.standardText(
                                      text: "Adultos",
                                      aling: TextAlign.center,
                                      color: Theme.of(context).primaryColor,
                                      overClip: true),
                                if (!cotizacion.esGrupo!)
                                  TextStyles.standardText(
                                      text: "Menores 0-6",
                                      aling: TextAlign.center,
                                      color: Theme.of(context).primaryColor,
                                      overClip: true),
                                TextStyles.standardText(
                                    text: (!cotizacion.esGrupo!)
                                        ? "Menores 7-12"
                                        : "1 o 2 Adultos",
                                    aling: TextAlign.center,
                                    color: Theme.of(context).primaryColor,
                                    overClip: true),
                                TextStyles.standardText(
                                    text: (!cotizacion.esGrupo!)
                                        ? "Tarifa \nReal"
                                        : "3 Adultos",
                                    aling: TextAlign.center,
                                    color: Theme.of(context).primaryColor,
                                    overClip: true),
                                if (cotizacion.esGrupo!)
                                  TextStyles.standardText(
                                      text: "  4 Adultos  ",
                                      aling: TextAlign.center,
                                      color: Theme.of(context).primaryColor,
                                      overClip: true),
                                if (cotizacion.esGrupo!)
                                  TextStyles.standardText(
                                      text: "Menores 7 a 12 Años",
                                      color: Theme.of(context).primaryColor,
                                      aling: TextAlign.center,
                                      overClip: true),
                                if (!cotizacion.esGrupo!)
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
                    if (!cotizacion.esGrupo!)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          height: Utility.limitHeightList(
                              cotizacion.habitaciones!.length),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: cotizacion.habitaciones!.length,
                            itemBuilder: (context, index) {
                              if (index < cotizacion.habitaciones!.length) {
                                return HabitacionItemRow(
                                  key: ObjectKey(
                                      cotizacion.habitaciones![index].hashCode),
                                  index: index,
                                  habitacion: cotizacion.habitaciones![index],
                                  isTable: !Utility.isResizable(
                                      extended: widget.sideController.extended,
                                      context: context),
                                  esDetalle: true,
                                  sideController: widget.sideController,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    if (cotizacion.esGrupo!)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          height: Utility.limitHeightList(
                              cotizacion.habitaciones!.length),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: cotizacion.habitaciones!.length,
                            itemBuilder: (context, index) {
                              if (index < cotizacion.habitaciones!.length) {
                                return HabitacionItemRow(
                                  key: ObjectKey(
                                      cotizacion.habitaciones![index].hashCode),
                                  index: index,
                                  habitacion: cotizacion.habitaciones![index],
                                  isTable: !Utility.isResizable(
                                      extended: widget.sideController.extended,
                                      context: context),
                                  esDetalle: true,
                                  sideController: widget.sideController,
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

                            if (cotizacion.esGrupo!) {
                              comprobantePDF = await GeneradorDocService()
                                  .generarComprobanteCotizacionGrupal(
                                      cotizacion.habitaciones!, cotizacion);
                            } else {
                              comprobantePDF = await GeneradorDocService()
                                  .generarComprobanteCotizacionIndividual(
                                      habitaciones: cotizacion.habitaciones!,
                                      cotizacion: cotizacion);
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
              if (isLoading && !isFinish)
                ProgressIndicatorCustom(screenHight: screenHight),
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
