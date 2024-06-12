import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/cotizacion_model.dart';

import '../helpers/web_colors.dart';
import 'text_styles.dart';
import '../helpers/utility.dart';

class CotizacionListtile extends StatelessWidget {
  final int index;
  final Cotizacion cotizacion;
  final bool compact;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  const CotizacionListtile({
    super.key,
    required this.index,
    required this.cotizacion,
    required this.compact,
    required this.onPressedEdit,
    required this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      child: Card(
        elevation: 3,
        child: !compact
            ? ListTile(
                leading: TextStyles.dateTextSpecial(day: index + 1),
                visualDensity: VisualDensity.standard,
                title: TextStyles.standardText(
                    text: "${cotizacion.categoria} / ${cotizacion.plan}",
                    isBold: true),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.standardText(
                        text: Utility.getLengthStay(
                            cotizacion.fechaEntrada, cotizacion.noches),
                      ),
                      TextStyles.standardText(
                          text:
                              "Tarifa real: ${Utility.formatterNumber(cotizacion.tarifaReal!)}"),
                      TextStyles.standardText(
                        text:
                            "Tarifa preventa: ${(cotizacion.tarifaPreventa != null) ? Utility.formatterNumber(cotizacion.tarifaPreventa!) : Utility.formatterNumber(cotizacion.tarifaReal!)}",
                      )
                    ]),
                trailing: PopupMenuButton<ListTileTitleAlignment>(
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<ListTileTitleAlignment>>[
                    PopupMenuItem<ListTileTitleAlignment>(
                      value: ListTileTitleAlignment.threeLine,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.edit, color: WebColors.turqueza),
                          TextStyles.standardText(text: "Editar")
                        ],
                      ),
                    ),
                    PopupMenuItem<ListTileTitleAlignment>(
                      value: ListTileTitleAlignment.titleHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.delete, color: Colors.red[800]),
                          TextStyles.standardText(text: "Eliminar")
                        ],
                      ),
                    ),
                  ],
                ),
                isThreeLine: true,
              )
            : Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Table(
                      columnWidths: const {
                        0: FractionColumnWidth(.05),
                        1: FractionColumnWidth(.15),
                        2: FractionColumnWidth(.1),
                        3: FractionColumnWidth(.1),
                        4: FractionColumnWidth(.1),
                        5: FractionColumnWidth(.1),
                        6: FractionColumnWidth(.21),
                      },
                      border: const TableBorder(
                          horizontalInside: BorderSide(color: Colors.black87)),
                      children: [
                        TableRow(
                          children: [
                            TextStyles.standardText(
                              text: (index + 1).toString(),
                              aling: TextAlign.center,
                              overClip: true,
                            ),
                            TextStyles.standardText(
                              text: Utility.getLengthStay(
                                  cotizacion.fechaEntrada, cotizacion.noches),
                              aling: TextAlign.center,
                              overClip: true,
                            ),
                            TextStyles.standardText(
                                text: cotizacion.adultos.toString(),
                                aling: TextAlign.center,
                                overClip: true),
                            TextStyles.standardText(
                                text: cotizacion.menores0a6.toString(),
                                aling: TextAlign.center,
                                overClip: true),
                            TextStyles.standardText(
                                text: cotizacion.menores7a12.toString(),
                                aling: TextAlign.center,
                                overClip: true),
                            TextStyles.standardText(
                                text: Utility.formatterNumber(
                                    cotizacion.tarifaReal!),
                                aling: TextAlign.center,
                                overClip: true),
                            TextStyles.standardText(
                                text: (cotizacion.tarifaPreventa != null)
                                    ? Utility.formatterNumber(
                                        cotizacion.tarifaPreventa!)
                                    : Utility.formatterNumber(
                                        cotizacion.tarifaReal!),
                                aling: TextAlign.center,
                                overClip: true),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      color: WebColors.turqueza,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red[800],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextStyles.standardText(
                          text:
                              "Categoría: ${cotizacion.categoria!} / Plan: ${cotizacion.plan!}",
                          isBold: true),
                    )
                  ],
                ),
              ),
      ),
    )
        .animate()
        .fadeIn()
        .slideY(begin: -0.2, delay: const Duration(milliseconds: 200));
  }
}
