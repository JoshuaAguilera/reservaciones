import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/helpers/constants.dart';
import 'package:generador_formato/models/cotizacion_model.dart';

import '../helpers/web_colors.dart';
import 'text_styles.dart';
import '../helpers/utility.dart';

class CotizacionIndividualCard extends StatefulWidget {
  final int index;
  final Cotizacion cotizacion;
  final bool compact;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final bool esDetalle;
  const CotizacionIndividualCard({
    super.key,
    required this.index,
    required this.cotizacion,
    required this.compact,
    this.onPressedEdit,
    this.onPressedDelete,
    this.esDetalle = false,
  });

  @override
  State<CotizacionIndividualCard> createState() =>
      _CotizacionIndividualCardState();
}

class _CotizacionIndividualCardState extends State<CotizacionIndividualCard> {
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
                  esDetalle: widget.esDetalle,
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
                  esDetalle: widget.esDetalle,
                )
          : selected
              ? _TableRowCotizacion(
                  index: widget.index,
                  cotizacion: widget.cotizacion,
                  onPressedDelete: null,
                  onPressedEdit: null,
                  esDetalle: widget.esDetalle,
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
                  esDetalle: widget.esDetalle,
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
  final bool esDetalle;

  const _TableRowCotizacion({
    super.key,
    required this.index,
    required this.cotizacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
    required this.esDetalle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
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
                      text: (index + 1).toString(),
                      aling: TextAlign.center,
                      overClip: true,
                    ),
                    TextStyles.standardText(
                      text:
                          "${cotizacion.fechaEntrada} a ${cotizacion.fechaSalida}",
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
                            cotizacion.tarifaRealAdulto!),
                        aling: TextAlign.center,
                        overClip: true),
                    TextStyles.standardText(
                        text: (cotizacion.tarifaPreventaAdulto != null)
                            ? Utility.formatterNumber(
                                cotizacion.tarifaPreventaAdulto!)
                            : Utility.formatterNumber(
                                cotizacion.tarifaRealAdulto!),
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
                  text: "Categoría: ${cotizacion.categoria!} /" +
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
  final bool esDetalle;

  const _ListTileCotizacion({
    super.key,
    required this.index,
    required this.cotizacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
    required this.esDetalle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: TextStyles.TextSpecial(day: index + 1),
        visualDensity: VisualDensity.standard,
        title: TextStyles.standardText(
            text: "${cotizacion.categoria} / ${cotizacion.plan}", isBold: true),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextStyles.standardText(
              text: "${cotizacion.fechaEntrada} a ${cotizacion.fechaSalida}"),
          TextStyles.standardText(
              text:
                  "Tarifa real: ${Utility.formatterNumber(Utility.calculateTarifaDiaria(cotizacion: cotizacion))}"),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Tarifa preventa: ",
                  style: TextStyles.styleStandar(isBold: true)),
              TextSpan(
                  text:
                      "${Utility.formatterNumber(Utility.calculateTarifaDiaria(cotizacion: cotizacion, esPreventa: true))}    ",
                  style: TextStyles.styleStandar()),
            ]),
          ),
          if (esDetalle)
            Wrap(
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Menores 0-6: ',
                        style: TextStyles.styleStandar(isBold: true)),
                    TextSpan(
                        text: "${cotizacion.menores0a6}    ",
                        style: TextStyles.styleStandar()),
                  ]),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Menores 7-12: ',
                        style: TextStyles.styleStandar(isBold: true)),
                    TextSpan(
                        text: "${cotizacion.menores7a12}    ",
                        style: TextStyles.styleStandar()),
                  ]),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Adultos: ',
                        style: TextStyles.styleStandar(isBold: true)),
                    TextSpan(
                        text: "${cotizacion.adultos}",
                        style: TextStyles.styleStandar()),
                  ]),
                ),
              ],
            ),
        ]),
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

  Widget statisticsCustomers(Cotizacion cotizacion) {
    return Column(children: [
      Row(
        children: [],
      )
    ]);
  }
}
