import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/cotizacion_grupal_model.dart';

import '../utils/helpers/web_colors.dart';
import 'text_styles.dart';
import '../utils/helpers/utility.dart';

class CotizacionGrupoCard extends StatefulWidget {
  final int index;
  final CotizacionGrupal? cotGroup;
  final bool compact;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final bool isDetail;
  const CotizacionGrupoCard({
    super.key,
    required this.index,
    required this.compact,
    this.onPressedEdit,
    this.onPressedDelete,
    this.cotGroup,
    this.isDetail = false,
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
                  esDetalle: widget.isDetail,
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
                  esDetalle: widget.isDetail,
                )
          : selected
              ? _TableRowCotizacion(
                  index: widget.index,
                  cotizacion: widget.cotGroup!,
                  onPressedDelete: null,
                  onPressedEdit: null,
                  esDetalle: widget.isDetail,
                )
                  .animate()
                  .fadeOut()
                  .slideY(begin: -0.2, delay: const Duration(milliseconds: 200))
              : _TableRowCotizacion(
                  index: widget.index,
                  esDetalle: widget.isDetail,
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
  final bool esDetalle;
  const _TableRowCotizacion({
    super.key,
    required this.index,
    required this.cotizacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
    this.esDetalle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: DesktopColors.cotGroupColor,
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
                4: FractionColumnWidth(.12),
                5: FractionColumnWidth(.12),
                6: FractionColumnWidth(.12),
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
                        text: Utility.formatterNumber(
                            cotizacion.tarifaAdulto1_2 ?? 0),
                        aling: TextAlign.center,
                        overClip: true),
                    TextStyles.standardText(
                        text: Utility.formatterNumber(
                            cotizacion.tarifaAdulto3 ?? 0),
                        aling: TextAlign.center,
                        overClip: true),
                    TextStyles.standardText(
                        text: Utility.formatterNumber(
                            cotizacion.tarifaAdulto4 ?? 0),
                        aling: TextAlign.center,
                        overClip: true),
                    TextStyles.standardText(
                        text: Utility.formatterNumber(
                            cotizacion.tarifaMenor ?? 0),
                        aling: TextAlign.center,
                        overClip: true),
                    if (!esDetalle)
                      Wrap(
                        children: [
                          IconButton(
                            onPressed: onPressedEdit,
                            icon: Icon(
                              Icons.edit,
                              color: DesktopColors.ceruleanOscure,
                            ),
                          ),
                          IconButton(
                            onPressed: onPressedDelete,
                            icon: Icon(
                              Icons.delete,
                              color: DesktopColors.prussianBlue,
                            ),
                          ),
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
  final bool esDetalle;

  const _ListTileCotizacion({
    super.key,
    required this.index,
    required this.cotizacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
    this.esDetalle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: DesktopColors.cotGroupColor,
      elevation: 3,
      child: ListTile(
        leading: TextStyles.TextSpecial(
          day: index + 1,
          title: cotizacion.plan == "PLAN TODO INCLUIDO" ? "TDI" : "EP",
          subtitle: "PLAN",
          colorTitle: DesktopColors.azulUltClaro,
        ),
        visualDensity: VisualDensity.standard,
        title: TextStyles.standardText(
            text: "${cotizacion.categoria}", isBold: true),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyles.standardText(
              text: "${cotizacion.fechaEntrada} a ${cotizacion.fechaSalida}",
            ),
            Wrap(
              spacing: 5,
              runSpacing: 2,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.person_fill, size: 20),
                      TextStyles.standardText(text: " - ", isBold: true),
                      Icon(CupertinoIcons.person_2_fill),
                      TextStyles.standardText(
                          text:
                              "   ${Utility.formatterNumber(cotizacion.tarifaAdulto1_2!)}"),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(CupertinoIcons.person_3_fill, size: 32),
                    TextStyles.standardText(
                        text:
                            "   ${Utility.formatterNumber(cotizacion.tarifaAdulto3!)}"),
                  ],
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.person_2_fill),
                    Icon(CupertinoIcons.person_2_fill),
                    TextStyles.standardText(
                        text:
                            "   ${Utility.formatterNumber(cotizacion.tarifaAdulto4!)}"),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person_4_sharp,
                      size: 22,
                    ),
                    TextStyles.standardText(
                        text:
                            "(7-12)   ${Utility.formatterNumber(cotizacion.tarifaMenor!)}"),
                  ],
                ),
              ],
            ),
          ],
        ),
        trailing: esDetalle
            ? null
            : PopupMenuButton<ListTileTitleAlignment>(
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
