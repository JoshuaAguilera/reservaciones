import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/habitacion_model.dart';

import '../utils/helpers/web_colors.dart';
import 'text_styles.dart';
import '../utils/helpers/utility.dart';

class HabitacionItemRow extends StatefulWidget {
  final int index;
  final Habitacion habitacion;
  final bool compact;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final bool esDetalle;
  const HabitacionItemRow({
    super.key,
    required this.index,
    required this.habitacion,
    required this.compact,
    this.onPressedEdit,
    this.onPressedDelete,
    this.esDetalle = false,
  });

  @override
  State<HabitacionItemRow> createState() =>
      _HabitacionItemRowState();
}

class _HabitacionItemRowState extends State<HabitacionItemRow> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: !widget.compact
          ? selected
              ? _ListTileCotizacion(
                  index: widget.index,
                  cotizacion: widget.habitacion,
                  onPressedDelete: null,
                  onPressedEdit: null,
                  esDetalle: widget.esDetalle,
                )
                  .animate()
                  .fadeOut()
                  .slideY(begin: -0.2, delay: const Duration(milliseconds: 200))
              : _ListTileCotizacion(
                  index: widget.index,
                  cotizacion: widget.habitacion,
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
                  cotizacion: widget.habitacion,
                  onPressedDelete: null,
                  onPressedEdit: null,
                  esDetalle: widget.esDetalle,
                )
                  .animate()
                  .fadeOut()
                  .slideY(begin: -0.2, delay: const Duration(milliseconds: 200))
              : _TableRowCotizacion(
                  index: widget.index,
                  cotizacion: widget.habitacion,
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
  final Habitacion cotizacion;
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
      color: cotizacion.esPreventa!
          ? DesktopColors.cotIndPreColor
          : DesktopColors.cotIndColor,
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: const FractionColumnWidth(.05),
                1: const FractionColumnWidth(.15),
                2: const FractionColumnWidth(.1),
                3: const FractionColumnWidth(.1),
                4: const FractionColumnWidth(.1),
                5: const FractionColumnWidth(.1),
                if (!esDetalle) 6: const FractionColumnWidth(.21),
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
                      color: cotizacion.esPreventa!
                          ? null
                          : DesktopColors.azulUltClaro,
                    ),
                    TextStyles.standardText(
                      text:
                          "${cotizacion.fechaCheckIn} a ${cotizacion.fechaCheckOut}",
                      aling: TextAlign.center,
                      overClip: true,
                      color: cotizacion.esPreventa!
                          ? null
                          : DesktopColors.azulUltClaro,
                    ),
                    TextStyles.standardText(
                      text: cotizacion.folioHabitacion.toString(),
                      aling: TextAlign.center,
                      color: cotizacion.esPreventa!
                          ? null
                          : DesktopColors.azulUltClaro,
                      overClip: true,
                    ),
                    TextStyles.standardText(
                      text: cotizacion.folioHabitacion.toString(),
                      aling: TextAlign.center,
                      color: cotizacion.esPreventa!
                          ? null
                          : DesktopColors.azulUltClaro,
                      overClip: true,
                    ),
                    TextStyles.standardText(
                      text: cotizacion.folioHabitacion.toString(),
                      aling: TextAlign.center,
                      color: cotizacion.esPreventa!
                          ? null
                          : DesktopColors.azulUltClaro,
                      overClip: true,
                    ),
                    TextStyles.standardText(
                      text: Utility.formatterNumber(
                          Utility.calculateTarifaDiaria(
                              cotizacion: cotizacion)),
                      aling: TextAlign.center,
                      color: cotizacion.esPreventa!
                          ? null
                          : DesktopColors.azulUltClaro,
                      overClip: true,
                    ),
                    TextStyles.standardText(
                      text: Utility.formatterNumber(
                          Utility.calculateTarifaDiaria(
                              cotizacion: cotizacion,
                              esPreventa: cotizacion.esPreventa!)),
                      aling: TextAlign.center,
                      color: cotizacion.esPreventa!
                          ? null
                          : DesktopColors.azulUltClaro,
                      overClip: true,
                    ),
                    if (!esDetalle)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: onPressedEdit,
                            icon: Icon(
                              Icons.edit,
                              color: cotizacion.esPreventa!
                                  ? DesktopColors.ceruleanOscure
                                  : DesktopColors.azulClaro,
                            ),
                          ),
                          IconButton(
                            onPressed: onPressedDelete,
                            icon: Icon(
                              Icons.delete,
                              color: cotizacion.esPreventa!
                                  ? DesktopColors.prussianBlue
                                  : DesktopColors.azulCielo,
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
                text: "Categoría: ${cotizacion.categoria!} /" +
                    " Plan: ${cotizacion.plan!}",
                isBold: true,
                color:
                    cotizacion.esPreventa! ? null : DesktopColors.azulUltClaro,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ListTileCotizacion extends StatelessWidget {
  final int index;
  final Habitacion cotizacion;
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
      color: cotizacion.esPreventa!
          ? DesktopColors.cotIndPreColor
          : DesktopColors.cotIndColor,
      elevation: 5,
      child: ListTile(
        leading: TextStyles.TextSpecial(
          day: index + 1,
          colorTitle:
              cotizacion.esPreventa! ? null : DesktopColors.azulUltClaro,
          colorsubTitle:
              cotizacion.esPreventa! ? null : DesktopColors.azulCielo,
        ),
        visualDensity: VisualDensity.standard,
        title: TextStyles.standardText(
          text: "${cotizacion.categoria} / ${cotizacion.plan}",
          isBold: true,
          color: cotizacion.esPreventa! ? null : DesktopColors.azulUltClaro,
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextStyles.standardText(
            text: "${cotizacion.fechaCheckIn} a ${cotizacion.fechaCheckOut}",
            color: cotizacion.esPreventa! ? null : DesktopColors.azulUltClaro,
          ),
          TextStyles.TextAsociative(
            "Tarifa real:",
            Utility.formatterNumber(
                Utility.calculateTarifaDiaria(cotizacion: cotizacion)),
            color: cotizacion.esPreventa! ? null : DesktopColors.azulUltClaro,
          ),
          TextStyles.TextAsociative(
            "Tarifa preventa: ",
            Utility.formatterNumber(Utility.calculateTarifaDiaria(
                cotizacion: cotizacion, esPreventa: true)),
            color: cotizacion.esPreventa! ? null : DesktopColors.azulUltClaro,
          ),
          if (esDetalle)
            Wrap(
              children: [
                TextStyles.TextAsociative(
                    'Menores 0-6: ', "${cotizacion.folioHabitacion}    ",
                    color: DesktopColors.azulUltClaro),
                TextStyles.TextAsociative(
                    'Menores 7-12: ', "${cotizacion.folioHabitacion}    ",
                    color: DesktopColors.azulUltClaro),
                TextStyles.TextAsociative('Adultos: ', "${cotizacion.folioHabitacion}",
                    color: DesktopColors.azulUltClaro),
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

  Widget statisticsCustomers(Habitacion cotizacion) {
    return const Column(children: [
      Row(
        children: [],
      )
    ]);
  }
}
