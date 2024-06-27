import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/providers/comprobante_provider.dart';
import 'package:sidebarx/src/controller/sidebarx_controller.dart';

import '../helpers/utility.dart';
import '../helpers/web_colors.dart';
import '../widgets/cotizacion_indiv_card.dart';
import '../widgets/text_styles.dart';
import '../widgets/textformfield_custom.dart';

class ComprobanteDetalleView extends ConsumerStatefulWidget {
  const ComprobanteDetalleView({super.key, required this.sideController});

  final SidebarXController sideController;
  @override
  _ComprobanteDetalleViewState createState() => _ComprobanteDetalleViewState();
}

class _ComprobanteDetalleViewState
    extends ConsumerState<ComprobanteDetalleView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final comprobante = ref.watch(comprobanteDetalleProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => widget.sideController.selectIndex(2),
                    icon: Icon(
                      CupertinoIcons.chevron_left_circle,
                      color: WebColors.prussianBlue,
                      size: 30,
                    )),
                Expanded(
                  child: TextStyles.titlePagText(
                    text: "Detalles de cotización - ${comprobante.folioCuotas}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.black54),
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
                            text: "Correo electronico: ${comprobante.correo!}"),
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
                    extended: widget.sideController.extended, context: context))
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Table(
                      columnWidths: {
                        0: const FractionColumnWidth(.05),
                        1: const FractionColumnWidth(.15),
                        2: const FractionColumnWidth(.1),
                        3: const FractionColumnWidth(.1),
                        4: const FractionColumnWidth(.1),
                        // 5: FractionColumnWidth(
                        //     (dropdownValue == "Cotización Individual")
                        //         ? .1
                        //         : 0.22),
                        // 6: FractionColumnWidth(
                        //     (dropdownValue == "Cotización Individual")
                        //         ? .21
                        //         : .1),
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
                          const SizedBox(width: 15)
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
                        // if (_formKeyCotizacion.currentState!.validate()) {
                        //   if (cotizaciones.isEmpty) {
                        //     showSnackBar(
                        //       context: context,
                        //       title: "Cotizaciones no registradas",
                        //       message: "Se requiere al menos una cotización",
                        //     );
                        //     return;
                        //   }

                        //   setState(() => isLoading = true);

                        //   if (await ComprobanteService().createComprobante(
                        //       comprobante, cotizaciones, folio)) {}

                        //   comprobantePDF = await ref
                        //       .watch(CotizacionIndividualProvider
                        //           .provider.notifier)
                        //       .generarComprobante(comprobante);

                        //   Future.delayed(
                        //       Durations.extralong1,
                        //       () => setState(() {
                        //             isFinish = true;
                        //             comprobante.correo = "";
                        //             comprobante.nombre = "";
                        //             comprobante.telefono = "";
                        //             cotizaciones.clear();
                        //           }));
                        // }
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
          ],
        ),
      ),
    );
  }
}
