import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/cotizacion_model.dart';

import '../helpers/web_colors.dart';
import 'text_styles.dart';
import '../helpers/utility.dart';

class CotizacionGrupoCard extends StatefulWidget {
  final int index;
  final Cotizacion cotizacion;
  final bool compact;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  const CotizacionGrupoCard({
    super.key,
    required this.index,
    required this.cotizacion,
    required this.compact,
    required this.onPressedEdit,
    required this.onPressedDelete,
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
                  cotizacion: widget.cotizacion,
                  onPressedDelete: null,
                  onPressedEdit: null,
                )
                  .animate()
                  .fadeOut()
                  .slideY(begin: -0.2, delay: const Duration(milliseconds: 200))
              : _ListTileCotizacion(
                  index: widget.index,
                  cotizacion: widget.cotizacion,
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
                  cotizacion: widget.cotizacion,
                  onPressedDelete: null,
                  onPressedEdit: null,
                )
                  .animate()
                  .fadeOut()
                  .slideY(begin: -0.2, delay: const Duration(milliseconds: 200))
              : _TableRowCotizacion(
                  index: widget.index,
                  cotizacion: widget.cotizacion,
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
  final Cotizacion cotizacion;
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
                      text: cotizacion.pax.toString(),
                      aling: TextAlign.center,
                      overClip: true,
                    ),
                    TextStyles.standardText(
                      text: Utility.getLengthStay(cotizacion.fechaEntrada, 23),
                      aling: TextAlign.center,
                      overClip: true,
                    ),
                    TextStyles.standardText(
                        text: cotizacion.adultos.toString(),
                        aling: TextAlign.center,
                        overClip: true),
                    TextStyles.standardText(
                        text: cotizacion.menores7a12.toString(),
                        aling: TextAlign.center,
                        overClip: true),
                    TextStyles.standardText(
                        text: Utility.formatterNumber(cotizacion.tarifaNoche!),
                        aling: TextAlign.center,
                        overClip: true),
                    TextStyles.standardText(
                        text: cotizacion.adultos.toString(),
                        aling: TextAlign.center,
                        overClip: true),
                    TextStyles.standardText(
                        text: Utility.formatterNumber(cotizacion.subtotal!),
                        aling: TextAlign.center,
                        overClip: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: onPressedEdit,
                            icon: Icon(
                              Icons.edit,
                              color: WebColors.turqueza,
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
                  text: "Tipo Habitación: ${cotizacion.tipoHabitacion!} /" +
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
  final Cotizacion cotizacion;
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
            day: index + 1,
            title: Utility.getPax(cotizacion.pax!),
            subtitle: "PAX"),
        visualDensity: VisualDensity.standard,
        title: TextStyles.standardText(
            text: "${cotizacion.tipoHabitacion} / ${cotizacion.plan}",
            isBold: true),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextStyles.standardText(
            text: Utility.getLengthStay(cotizacion.fechaEntrada, 2),
          ),
          TextStyles.standardText(
              text:
                  "Tarifa por noche: ${Utility.formatterNumber(cotizacion.tarifaNoche!)}"),
          TextStyles.standardText(
            text: "Subtotal: ${Utility.formatterNumber(cotizacion.subtotal!)}",
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
                  Icon(Icons.edit, color: WebColors.turqueza),
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
