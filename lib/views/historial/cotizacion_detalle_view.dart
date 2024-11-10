import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/cotizacion_provider.dart';
import 'package:generador_formato/widgets/habitacion_item_row.dart';
import 'package:generador_formato/widgets/summary_controller_widget.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../utils/helpers/utility.dart';
import '../../utils/helpers/web_colors.dart';
import '../../services/generador_doc_service.dart';
import '../../ui/progress_indicator.dart';
import '../../widgets/text_styles.dart';
import '../generacion_cotizaciones/pdf_cotizacion_view.dart';

class CotizacionDetalleView extends ConsumerStatefulWidget {
  const CotizacionDetalleView({super.key, required this.sideController});

  final SidebarXController sideController;
  @override
  _CotizacionDetalleViewState createState() => _CotizacionDetalleViewState();
}

class _CotizacionDetalleViewState extends ConsumerState<CotizacionDetalleView> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenWidthWithSideBar = screenWidth +
        (screenWidth > 800 ? (widget.sideController.extended ? 50 : 180) : 300);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              child: IconButton(
                                onPressed: () {
                                  if (!isFinish) {
                                    widget.sideController.selectIndex(2);
                                  } else {
                                    isFinish = false;
                                    isLoading = false;
                                    setState(() {});
                                  }
                                },
                                icon: Icon(CupertinoIcons.chevron_left_circle,
                                    color: Theme.of(context).primaryColor),
                                iconSize: 30,
                              ),
                            ),
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
                        const Divider(),
                        if (!isLoading)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              TextStyles.titleText(text: "Datos del huesped"),
                              Card(
                                elevation: 7,
                                color: Colors.blue[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextStyles.TextAsociative(
                                          "Nombre: ", cotizacion.nombreHuesped!,
                                          size: 13),
                                      TextStyles.TextAsociative(
                                          "Correo electronico: ",
                                          cotizacion.correoElectronico!,
                                          size: 13),
                                      TextStyles.TextAsociative("Telefono: ",
                                          cotizacion.numeroTelefonico!,
                                          size: 13),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Divider()),
                              TextStyles.titleText(text: "Cotizaciones"),
                              const SizedBox(height: 12),
                              if (!Utility.isResizable(
                                  extended: widget.sideController.extended,
                                  context: context))
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 5),
                                    child: Table(
                                      border: TableBorder(
                                        verticalInside: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          width: 2,
                                        ),
                                      ),
                                      columnWidths: {
                                        0: const FractionColumnWidth(0.1),
                                        if (screenWidthWithSideBar < 1250 &&
                                            screenWidthWithSideBar > 950)
                                          1: const FractionColumnWidth(0.35),
                                        if (screenWidthWithSideBar < 1550 &&
                                            screenWidthWithSideBar > 1250)
                                          2: const FractionColumnWidth(0.1),
                                        if (screenWidthWithSideBar < 1550 &&
                                            screenWidthWithSideBar > 1350)
                                          3: const FractionColumnWidth(0.1),
                                        if (screenWidthWithSideBar < 1550 &&
                                            screenWidthWithSideBar > 1450)
                                          4: const FractionColumnWidth(0.1),
                                      },
                                      children: [
                                        TableRow(
                                          children: [
                                            for (var item in [
                                              "#",
                                              if (screenWidthWithSideBar > 950)
                                                "Fechas de estancia",
                                              if (screenWidthWithSideBar > 1250)
                                                "Adultos",
                                              if (screenWidthWithSideBar > 1450)
                                                "Menores 0-6",
                                              if (screenWidthWithSideBar > 1350)
                                                "Menores 7-12",
                                              if (screenWidthWithSideBar > 1700)
                                                "Tarifa Real",
                                              if (screenWidthWithSideBar > 1550)
                                                "Tarifa Total",
                                              "Cantidad",
                                            ])
                                              TextStyles.standardText(
                                                text: item,
                                                aling: TextAlign.center,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                overClip: true,
                                                size: 11.5,
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                                      if (index <
                                          cotizacion.habitaciones!.length) {
                                        return HabitacionItemRow(
                                          key: ObjectKey(cotizacion
                                              .habitaciones![index].hashCode),
                                          index: index,
                                          habitacion:
                                              cotizacion.habitaciones![index],
                                          isTable: !Utility.isResizable(
                                              extended: widget
                                                  .sideController.extended,
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
                                child: Divider(),
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
                                                cotizacion.habitaciones!,
                                                cotizacion);
                                      } else {
                                        comprobantePDF = await GeneradorDocService()
                                            .generarComprobanteCotizacionIndividual(
                                                habitaciones:
                                                    cotizacion.habitaciones!,
                                                cotizacion: cotizacion);
                                      }

                                      Future.delayed(
                                        Durations.long2,
                                        () => setState(() => isFinish = true),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 4,
                                        backgroundColor:
                                            DesktopColors.ceruleanOscure),
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
                          PdfCotizacionView(
                            comprobantePDF: comprobantePDF,
                            cotizacion: cotizacion,
                            isDetail: true,
                          ),
                      ],
                    ),
                  ),
                  SummaryControllerWidget(
                    withSaveButton: false,
                    saveRooms: cotizacion.habitaciones,
                    finishQuote: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
