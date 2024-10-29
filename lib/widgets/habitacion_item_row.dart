import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/ui/custom_widgets.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:sidebarx/sidebarx.dart';

import '../providers/habitacion_provider.dart';
import '../providers/tarifario_provider.dart';
import '../utils/helpers/web_colors.dart';
import 'dialogs.dart';
import 'text_styles.dart';
import '../utils/helpers/utility.dart';

class HabitacionItemRow extends StatefulWidget {
  final int index;
  final Habitacion habitacion;
  final bool isTable;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final bool esDetalle;
  final SidebarXController sideController;
  const HabitacionItemRow({
    super.key,
    required this.index,
    required this.habitacion,
    required this.isTable,
    this.onPressedEdit,
    this.onPressedDelete,
    this.esDetalle = false,
    required this.sideController,
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
        contentText:
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
                  sideController: widget.sideController,
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
                  sideController: widget.sideController,
                )
          : selected
              ? _TableRowCotizacion(
                  index: widget.index,
                  habitacion: widget.habitacion,
                  onPressedDelete: null,
                  onPressedEdit: null,
                  esDetalle: widget.esDetalle,
                  sideController: widget.sideController,
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
                  sideController: widget.sideController,
                ),
    )
        .animate()
        .fadeIn()
        .slideY(begin: -0.2, delay: const Duration(milliseconds: 200));
  }
}

class _TableRowCotizacion extends ConsumerStatefulWidget {
  final int index;
  final Habitacion habitacion;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final bool esDetalle;
  final SidebarXController sideController;

  const _TableRowCotizacion({
    super.key,
    required this.index,
    required this.habitacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
    required this.esDetalle,
    required this.sideController,
  });

  @override
  _TableRowCotizacionState createState() => _TableRowCotizacionState();
}

class _TableRowCotizacionState extends ConsumerState<_TableRowCotizacion> {
  @override
  Widget build(BuildContext context) {
    final politicaTarifaProvider = ref.watch(tariffPolicyProvider(""));
    final habitaciones = ref.watch(HabitacionProvider.provider);

    Color? colorCard = widget.habitacion.isFree
        ? Colors.green[200]
        : widget.habitacion.categoria == tipoHabitacion.first
            ? DesktopColors.cotIndColor
            : DesktopColors.cotIndPreColor;
    Color? colorText = widget.habitacion.isFree
        ? Colors.black87
        : widget.habitacion.categoria == tipoHabitacion.first
            ? DesktopColors.azulUltClaro
            : DesktopColors.ceruleanOscure;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenWidthWithSideBar = screenWidth +
        (screenWidth > 800 ? (widget.sideController.extended ? 50 : 180) : 300);

    void updateList(int value, Politica? politica) {
      setState(() => widget.habitacion.count = value);
      ref
          .read(detectChangeRoomProvider.notifier)
          .update((state) => UniqueKey().hashCode);

      if (politica != null) {
        if (Utility.verifAddRoomFree(
            habitaciones, politica.intervaloHabitacionGratuita!)) {
          final habitacionesProvider = HabitacionProvider.provider;
          ref.read(habitacionesProvider.notifier).addFreeItem(
              widget.habitacion, politica.intervaloHabitacionGratuita!);
        } else if (Utility.verifAddRoomFree(
            habitaciones, politica.intervaloHabitacionGratuita!,
            isReduced: true)) {
          final habitacionesProvider = HabitacionProvider.provider;
          ref
              .read(habitacionesProvider.notifier)
              .removeFreeItem(politica.intervaloHabitacionGratuita!, widget.habitacion.folioHabitacion!);
         // ref.watch(habitacionesProvider.notifier).state = [...habitaciones];
        }
      }
    }

    return Card(
      color: colorCard,
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Column(
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                    if (screenWidthWithSideBar > 950)
                      TextStyles.standardText(
                        text:
                            "${widget.habitacion.fechaCheckIn} a ${widget.habitacion.fechaCheckOut}",
                        aling: TextAlign.center,
                        color: colorText,
                        size: 12,
                      ),
                    if (screenWidthWithSideBar > 1250)
                      TextStyles.standardText(
                        text: widget.habitacion.adultos!.toString(),
                        aling: TextAlign.center,
                        color: colorText,
                        size: 12,
                      ),
                    if (screenWidthWithSideBar > 1450)
                      TextStyles.standardText(
                        text: widget.habitacion.menores0a6!.toString(),
                        aling: TextAlign.center,
                        color: colorText,
                        size: 12,
                      ),
                    if (screenWidthWithSideBar > 1350)
                      TextStyles.standardText(
                        text: widget.habitacion.menores7a12!.toString(),
                        aling: TextAlign.center,
                        color: colorText,
                        size: 12,
                      ),
                    if (screenWidthWithSideBar > 1700)
                      TextStyles.standardText(
                        text: Utility.formatterNumber(
                            widget.habitacion.totalReal ?? 0),
                        aling: TextAlign.center,
                        color: colorText,
                        size: 12,
                      ),
                    if (screenWidthWithSideBar > 1550)
                      TextStyles.standardText(
                        text: Utility.formatterNumber(
                            widget.habitacion.total ?? 0),
                        aling: TextAlign.center,
                        color: colorText,
                        size: 12,
                      ),
                    if (!widget.esDetalle && !widget.habitacion.isFree)
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        children: [
                          politicaTarifaProvider.when(
                            data: (data) => SizedBox(
                              width: 87,
                              child: FormWidgets.inputCountField(
                                colorText: colorText,
                                initialValue:
                                    widget.habitacion.count.toString(),
                                nameField: "Cant: ",
                                onChanged: (p0) => updateList(
                                    (p0.isEmpty || int.parse(p0) < 1)
                                        ? 1
                                        : int.parse(p0),
                                    data),
                                onDecrement: (p0) {},
                                onIncrement: (p0) {},
                              ),
                            ),
                            error: (error, stackTrace) => TextStyles.errorText(
                                text: "Error al cargar politicas"),
                            loading: () => const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                  color: Colors.white),
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
                      )
                    else
                      TextStyles.standardText(
                        text: "${widget.habitacion.count} Room(s)",
                        aling: TextAlign.center,
                        color: colorText,
                        size: 12,
                        isBold: true,
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

class _ListTileCotizacion extends ConsumerStatefulWidget {
  final int index;
  final Habitacion habitacion;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final bool esDetalle;
  final SidebarXController sideController;

  const _ListTileCotizacion({
    super.key,
    required this.index,
    required this.habitacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
    required this.esDetalle,
    required this.sideController,
  });

  @override
  _ListTileCotizacionState createState() => _ListTileCotizacionState();
}

class _ListTileCotizacionState extends ConsumerState<_ListTileCotizacion> {
  @override
  Widget build(BuildContext context) {
    final politicaTarifaProvider = ref.watch(tariffPolicyProvider(""));

    Color colorCard = widget.habitacion.categoria == tipoHabitacion.first
        ? DesktopColors.cotIndColor
        : DesktopColors.cotIndPreColor;
    Color colorText = widget.habitacion.categoria == tipoHabitacion.first
        ? DesktopColors.azulUltClaro
        : DesktopColors.ceruleanOscure;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenWidthWithSideBar = screenWidth +
        (screenWidth > 800 ? (widget.sideController.extended ? 50 : 180) : 50);

    void updateList(int value) {
      setState(() => widget.habitacion.count = value);
      ref
          .read(detectChangeRoomProvider.notifier)
          .update((state) => UniqueKey().hashCode);
    }

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
            TextStyles.TextAsociative(
              (screenWidthWithSideBar < 1100)
                  ? "Fechas: "
                  : "Fechas de estancia: ",
              "${widget.habitacion.fechaCheckIn} a ${widget.habitacion.fechaCheckOut}",
              color: colorText,
            ),
            TextStyles.TextAsociative(
              "Tarifa real: ",
              Utility.formatterNumber(widget.habitacion.totalReal ?? 0),
              color: colorText,
            ),
            TextStyles.TextAsociative(
              (screenWidthWithSideBar < 1100)
                  ? "Tarifa desc: "
                  : "Tarifa descontada: ",
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
            if (screenWidthWithSideBar < 1100)
              politicaTarifaProvider.when(
                data: (data) => optionsListTile(
                  colorText: colorText,
                  onChanged: (p0) => updateList(p0.isEmpty ? 1 : int.parse(p0)),
                  onDecrement: (p0) => updateList(p0 < 1 ? 1 : p0),
                  onIncrement: (p0) => updateList(p0),
                ),
                error: (error, stackTrace) =>
                    TextStyles.errorText(text: "Error al cargar politicas"),
                loading: () => const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        ),
        trailing: (widget.esDetalle || screenWidthWithSideBar < 1100)
            ? null
            : politicaTarifaProvider.when(
                data: (data) => optionsListTile(
                  colorText: colorText,
                  onChanged: (p0) => updateList(p0.isEmpty ? 1 : int.parse(p0)),
                  onDecrement: (p0) => updateList(p0 < 1 ? 1 : p0),
                  onIncrement: (p0) => updateList(p0),
                ),
                error: (error, stackTrace) =>
                    TextStyles.errorText(text: "Error al cargar politicas"),
                loading: () => const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
        isThreeLine: true,
      ),
    );
  }

  Widget optionsListTile({
    required Color colorText,
    required void Function(String) onChanged,
    required void Function(int) onDecrement,
    required void Function(int) onIncrement,
  }) {
    return Wrap(
      spacing: 5,
      children: [
        SizedBox(
          width: 87,
          child: FormWidgets.inputCountField(
            colorText: colorText,
            initialValue: widget.habitacion.count.toString(),
            nameField: "Cant: ",
            onChanged: onChanged,
            onDecrement: onDecrement,
            onIncrement: onIncrement,
          ),
        ),
        SizedBox(
          height: 35,
          width: 40,
          child: CustomWidgets.compactOptions(
            context,
            onPreseedDelete: widget.onPressedDelete,
            onPreseedEdit: widget.onPressedEdit,
            colorIcon: colorText,
          ),
        ),
      ],
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
