import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/ui/custom_widgets.dart';
import 'package:generador_formato/utils/helpers/constants.dart';

import '../utils/helpers/web_colors.dart';
import 'dialogs.dart';
import 'number_input_with_increment_decrement.dart';
import 'text_styles.dart';
import '../utils/helpers/utility.dart';

class HabitacionItemRow extends StatefulWidget {
  final int index;
  final Habitacion habitacion;
  final bool isTable;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final bool esDetalle;
  const HabitacionItemRow({
    super.key,
    required this.index,
    required this.habitacion,
    required this.isTable,
    this.onPressedEdit,
    this.onPressedDelete,
    this.esDetalle = false,
  });

  @override
  State<HabitacionItemRow> createState() => _HabitacionItemRowState();
}

class _HabitacionItemRowState extends State<HabitacionItemRow> {
  bool selected = false;

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialogs.customAlertDialog(
        context: context,
        title: "Eliminar Habitación",
        content:
            "¿Desea eliminar la presente habitación\nde la cotización actual?",
        funtionMain: () {
          setState(() {
            selected = !selected;
          });
          Future.delayed(Durations.extralong2, widget.onPressedDelete);
        },
        nameButtonCancel: "NO",
        nameButtonMain: "SI",
        withButtonCancel: true,
        iconData: Icons.delete,
        iconColor: Theme.of(context).primaryColor,
        colorTextButton: Theme.of(context).dividerColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !widget.isTable
          ? selected
              ? _ListTileCotizacion(
                  index: widget.index,
                  habitacion: widget.habitacion,
                  onPressedDelete: null,
                  onPressedEdit: null,
                  esDetalle: widget.esDetalle,
                )
                  .animate()
                  .fadeOut()
                  .slideY(begin: -0.2, delay: const Duration(milliseconds: 200))
              : _ListTileCotizacion(
                  index: widget.index,
                  habitacion: widget.habitacion,
                  onPressedDelete: () => showDeleteDialog(),
                  onPressedEdit: widget.onPressedEdit,
                  esDetalle: widget.esDetalle,
                )
          : selected
              ? _TableRowCotizacion(
                  index: widget.index,
                  habitacion: widget.habitacion,
                  onPressedDelete: null,
                  onPressedEdit: null,
                  esDetalle: widget.esDetalle,
                )
                  .animate()
                  .fadeOut()
                  .slideY(begin: -0.2, delay: const Duration(milliseconds: 200))
              : _TableRowCotizacion(
                  index: widget.index,
                  habitacion: widget.habitacion,
                  onPressedDelete: () => showDeleteDialog(),
                  onPressedEdit: widget.onPressedEdit,
                  esDetalle: widget.esDetalle,
                ),
    )
        .animate()
        .fadeIn()
        .slideY(begin: -0.2, delay: const Duration(milliseconds: 200));
  }
}

class _TableRowCotizacion extends StatefulWidget {
  final int index;
  final Habitacion habitacion;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final bool esDetalle;

  const _TableRowCotizacion({
    super.key,
    required this.index,
    required this.habitacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
    required this.esDetalle,
  });

  @override
  State<_TableRowCotizacion> createState() => _TableRowCotizacionState();
}

class _TableRowCotizacionState extends State<_TableRowCotizacion> {
  @override
  Widget build(BuildContext context) {
    Color colorCard = widget.habitacion.categoria == tipoHabitacion.first
        ? DesktopColors.cotIndColor
        : DesktopColors.cotIndPreColor;
    Color colorText = widget.habitacion.categoria == tipoHabitacion.first
        ? DesktopColors.azulUltClaro
        : DesktopColors.ceruleanOscure;

    return Card(
      color: colorCard,
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Column(
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FractionColumnWidth(.05),
                1: FractionColumnWidth(.2),
                2: FractionColumnWidth(.1),
                3: FractionColumnWidth(.1),
                5: FractionColumnWidth(.1),
                6: FractionColumnWidth(.1),
                7: FractionColumnWidth(.2),
              },
              border: const TableBorder(
                  horizontalInside: BorderSide(color: Colors.black87)),
              children: [
                TableRow(
                  children: [
                    TextStyles.standardText(
                      text: (widget.index + 1).toString(),
                      aling: TextAlign.center,
                      overClip: true,
                      color: colorText,
                      size: 12,
                    ),
                    TextStyles.standardText(
                      text:
                          "${widget.habitacion.fechaCheckIn} a ${widget.habitacion.fechaCheckOut}",
                      aling: TextAlign.center,
                      color: colorText,
                      size: 12,
                    ),
                    TextStyles.standardText(
                      text: widget.habitacion.adultos!.toString(),
                      aling: TextAlign.center,
                      color: colorText,
                      size: 12,
                    ),
                    TextStyles.standardText(
                      text: widget.habitacion.menores0a6!.toString(),
                      aling: TextAlign.center,
                      color: colorText,
                      size: 12,
                    ),
                    TextStyles.standardText(
                      text: widget.habitacion.menores7a12!.toString(),
                      aling: TextAlign.center,
                      color: colorText,
                      size: 12,
                    ),
                    TextStyles.standardText(
                      text: Utility.formatterNumber(
                          widget.habitacion.totalReal ?? 0),
                      aling: TextAlign.center,
                      color: colorText,
                      size: 12,
                    ),
                    TextStyles.standardText(
                      text:
                          Utility.formatterNumber(widget.habitacion.total ?? 0),
                      aling: TextAlign.center,
                      color: colorText,
                      size: 12,
                    ),
                    if (!widget.esDetalle)
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        children: [
                          SizedBox(
                            width: 87,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextStyles.standardText(
                                  text: "Cant: ",
                                  color: colorText,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 40,
                                  child: NumberInputWithIncrementDecrement(
                                    onChanged: (p0) => setState(() =>
                                        widget.habitacion.count =
                                            p0.isEmpty ? 1 : int.parse(p0)),
                                    initialValue:
                                        widget.habitacion.count.toString(),
                                    minimalValue: 1,
                                    sizeIcons: 14,
                                    height: 10,
                                    focused: true,
                                    maxValue: 106,
                                    onDecrement: (p0) => setState(
                                        () => widget.habitacion.count = p0),
                                    onIncrement: (p0) => setState(
                                        () => widget.habitacion.count = p0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 35,
                            child: CustomWidgets.compactOptions(
                              context,
                              onPreseedDelete: widget.onPressedDelete,
                              onPreseedEdit: widget.onPressedEdit,
                              colorIcon: colorText,
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ListTileCotizacion extends StatefulWidget {
  final int index;
  final Habitacion habitacion;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final bool esDetalle;

  const _ListTileCotizacion({
    super.key,
    required this.index,
    required this.habitacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
    required this.esDetalle,
  });

  @override
  State<_ListTileCotizacion> createState() => _ListTileCotizacionState();
}

class _ListTileCotizacionState extends State<_ListTileCotizacion> {
  @override
  Widget build(BuildContext context) {
    Color colorCard = widget.habitacion.categoria == tipoHabitacion.first
        ? DesktopColors.cotIndColor
        : DesktopColors.cotIndPreColor;
    Color colorText = widget.habitacion.categoria == tipoHabitacion.first
        ? DesktopColors.azulUltClaro
        : DesktopColors.ceruleanOscure;

    return Card(
      color: colorCard,
      elevation: 5,
      child: ListTile(
        leading: TextStyles.TextSpecial(
          day: widget.index + 1,
          colorTitle: colorText,
          colorsubTitle: colorText,
          subtitle: "Room",
          sizeSubtitle: 12,
        ),
        visualDensity: VisualDensity.standard,
        title: TextStyles.standardText(
          text: "${widget.habitacion.categoria}",
          isBold: true,
          color: colorText,
        ),
        subtitle: Wrap(
          spacing: 12,
          runSpacing: 5,
          children: [
            TextStyles.standardText(
              text:
                  "Fechas de estancia: ${widget.habitacion.fechaCheckIn} a ${widget.habitacion.fechaCheckOut}",
              color: colorText,
            ),
            TextStyles.TextAsociative(
              "Tarifa real: ",
              Utility.formatterNumber(widget.habitacion.totalReal ?? 0),
              color: colorText,
            ),
            TextStyles.TextAsociative(
              "Tarifa descontada: ",
              Utility.formatterNumber(-(widget.habitacion.descuento ?? 0)),
              color: colorText,
            ),
            TextStyles.TextAsociative(
              "Tarifa total: ",
              Utility.formatterNumber(widget.habitacion.total ?? 0),
              color: colorText,
            ),
            Wrap(
              spacing: 15,
              children: [
                TextStyles.TextAsociative(
                    'Menores 0-6: ', "${widget.habitacion.menores0a6}",
                    color: colorText),
                TextStyles.TextAsociative(
                    'Menores 7-12: ', "${widget.habitacion.menores7a12}",
                    color: colorText),
                TextStyles.TextAsociative(
                    'Adultos: ', "${widget.habitacion.adultos}",
                    color: colorText),
              ],
            ),
          ],
        ),
        trailing: widget.esDetalle
            ? null
            : CustomWidgets.compactOptions(
                context,
                onPreseedDelete: widget.onPressedDelete,
                onPreseedEdit: widget.onPressedEdit,
                colorIcon: colorText,
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
