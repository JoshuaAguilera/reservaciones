import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/cotizacion_grupal_model.dart';
import 'package:generador_formato/models/cotizacion_model.dart';

import '../utils/helpers/web_colors.dart';
import 'text_styles.dart';
import '../utils/helpers/utility.dart';

class CotizacionGrupoCard extends StatefulWidget {
  final int index;
  final CotizacionGrupal? cotGroup;
  final bool compact;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  const CotizacionGrupoCard({
    super.key,
    required this.index,
    required this.compact,
    required this.onPressedEdit,
    required this.onPressedDelete,
    this.cotGroup,
  });

  @override
  State<CotizacionGrupoCard> createState() => _CotizacionGrupoCardState();
}

class _CotizacionGrupoCardState extends State<CotizacionGrupoCard> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: !widget.compact
          ? selected
              ? _ListTileCotizacion(
                  index: widget.index,
                  cotizacion: widget.cotGroup!,
                  onPressedDelete: null,
                  onPressedEdit: null,
                )
                  .animate()
                  .fadeOut()
                  .slideY(begin: -0.2, delay: const Duration(milliseconds: 200))
              : _ListTileCotizacion(
                  index: widget.index,
                  cotizacion: widget.cotGroup!,
                  onPressedDelete: () {
                    setState(() {
                      selected = !selected;
                    });
                    Future.delayed(
                        Durations.extralong2, widget.onPressedDelete);
                  },
                  onPressedEdit: widget.onPressedEdit,
                )
          : selected
              ? _TableRowCotizacion(
                  index: widget.index,
                  cotizacion: widget.cotGroup!,
                  onPressedDelete: null,
                  onPressedEdit: null,
                )
                  .animate()
                  .fadeOut()
                  .slideY(begin: -0.2, delay: const Duration(milliseconds: 200))
              : _TableRowCotizacion(
                  index: widget.index,
                  cotizacion: widget.cotGroup!,
                  onPressedDelete: () {
                    setState(() {
                      selected = !selected;
                    });
                    Future.delayed(
                        Durations.extralong2, widget.onPressedDelete);
                  },
                  onPressedEdit: widget.onPressedEdit,
                ),
    )
        .animate()
        .fadeIn()
        .slideY(begin: -0.2, delay: const Duration(milliseconds: 200));
  }
}

class _TableRowCotizacion extends StatelessWidget {
  final int index;
  final CotizacionGrupal cotizacion;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  const _TableRowCotizacion({
    super.key,
    required this.index,
    required this.cotizacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FractionColumnWidth(.2),
                1: FractionColumnWidth(.22),
                2: FractionColumnWidth(.1),
                3: FractionColumnWidth(.22),
                4: FractionColumnWidth(.15),
                5: FractionColumnWidth(.15),
              },
              border: const TableBorder(
                  horizontalInside: BorderSide(color: Colors.black87)),
              children: [
                TableRow(
                  children: [
                    TextStyles.standardText(
                      text:
                          "${cotizacion.fechaEntrada} a ${cotizacion.fechaSalida}",
                      aling: TextAlign.center,
                      overClip: true,
                    ),
                    TextStyles.standardText(
                        text: cotizacion.tarifaAdulto1_2.toString(),
                        aling: TextAlign.center,
                        overClip: true),
                    TextStyles.standardText(
                        text: cotizacion.tarifaAdulto3.toString(),
                        aling: TextAlign.center,
                        overClip: true),
                    TextStyles.standardText(
                        text: cotizacion.tarifaAdulto4.toString(),
                        aling: TextAlign.center,
                        overClip: true),
                    TextStyles.standardText(
                        text: cotizacion.tarifaMenor.toString(),
                        aling: TextAlign.center,
                        overClip: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: onPressedEdit,
                            icon: Icon(
                              Icons.edit,
                              color: DesktopColors.turqueza,
                            )),
                        IconButton(
                            onPressed: onPressedDelete,
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
                  text: "Tipo Habitación: ${cotizacion.categoria!} /" +
                      " Plan: ${cotizacion.plan!}",
                  isBold: true),
            )
          ],
        ),
      ),
    );
  }
}

class _ListTileCotizacion extends StatelessWidget {
  final int index;
  final CotizacionGrupal cotizacion;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;

  const _ListTileCotizacion({
    super.key,
    required this.index,
    required this.cotizacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: TextStyles.TextSpecial(
            day: index + 1, title: "TDI", subtitle: "PLAN"),
        visualDensity: VisualDensity.standard,
        title: TextStyles.standardText(
            text: "${cotizacion.categoria}", isBold: true),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextStyles.standardText(
            text: "${cotizacion.fechaEntrada} a ${cotizacion.fechaSalida}",
          ),
          TextStyles.standardText(
              text:
                  "Tarifa ad1-2: ${Utility.formatterNumber(cotizacion.tarifaAdulto1_2!)}"),
          TextStyles.standardText(
            text:
                "Tarifa ad3: ${Utility.formatterNumber(cotizacion.tarifaAdulto3!)}",
          ),
          TextStyles.standardText(
            text:
                "Tarifa ad4: ${Utility.formatterNumber(cotizacion.tarifaAdulto4!)}",
          ),
          TextStyles.standardText(
            text:
                "Tarifa men7-12: ${Utility.formatterNumber(cotizacion.tarifaAdulto3!)}",
          )
        ]),
        trailing: PopupMenuButton<ListTileTitleAlignment>(
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<ListTileTitleAlignment>>[
            PopupMenuItem<ListTileTitleAlignment>(
              value: ListTileTitleAlignment.threeLine,
              onTap: onPressedEdit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.edit, color: DesktopColors.turqueza),
                  TextStyles.standardText(text: "Editar")
                ],
              ),
            ),
            PopupMenuItem<ListTileTitleAlignment>(
              value: ListTileTitleAlignment.titleHeight,
              onTap: onPressedDelete,
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
      ),
    );
  }
}
