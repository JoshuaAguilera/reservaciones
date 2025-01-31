import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/ui/custom_widgets.dart';
import 'package:generador_formato/widgets/form_widgets.dart';
import 'package:sidebarx/sidebarx.dart';

import '../models/registro_tarifa_model.dart';
import '../providers/habitacion_provider.dart';
import '../providers/tarifario_provider.dart';
import '../utils/helpers/desktop_colors.dart';
import '../utils/shared_preferences/preferences.dart';
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
  final void Function()? onPressedDuplicate;
  final bool esDetalle;
  final SidebarXController sideController;
  const HabitacionItemRow({
    super.key,
    required this.index,
    required this.habitacion,
    required this.isTable,
    this.onPressedEdit,
    this.onPressedDelete,
    this.onPressedDuplicate,
    this.esDetalle = false,
    required this.sideController,
  });

  @override
  State<HabitacionItemRow> createState() => _HabitacionItemRowState();
}

class _HabitacionItemRowState extends State<HabitacionItemRow> {
  bool selected = false;
  double target = 1;

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
            target = 0;
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
          ? _ListTileCotizacion(
              index: widget.index,
              habitacion: widget.habitacion,
              onPressedDelete: selected ? null : () => showDeleteDialog(),
              onPressedEdit: selected ? null : widget.onPressedEdit,
              onPressedDuplicate: selected ? null : widget.onPressedDuplicate,
              esDetalle: widget.esDetalle,
              sideController: widget.sideController,
            )
          : _TableRowCotizacion(
              index: widget.index,
              habitacion: widget.habitacion,
              onPressedDelete: selected ? null : () => showDeleteDialog(),
              onPressedEdit: selected ? null : widget.onPressedEdit,
              onPressedDuplicate: selected ? null : widget.onPressedDuplicate,
              esDetalle: widget.esDetalle,
              sideController: widget.sideController,
            ),
    ).animate(target: target).fadeIn().slideY(
        begin: target < 1 ? 0.1 : -0.2,
        delay: const Duration(milliseconds: 200));
  }
}

class _TableRowCotizacion extends ConsumerStatefulWidget {
  final int index;
  final Habitacion habitacion;
  final void Function()? onPressedEdit;
  final void Function()? onPressedDelete;
  final void Function()? onPressedDuplicate;
  final bool esDetalle;
  final SidebarXController sideController;

  const _TableRowCotizacion({
    super.key,
    required this.index,
    required this.habitacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
    required this.onPressedDuplicate,
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
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    final typeQuote = ref.watch(typeQuoteProvider);
    final useCashSeason = ref.watch(useCashSeasonProvider);

    Color colorCard = brightness == Brightness.light
        ? const Color.fromARGB(255, 243, 243, 243)
        : DesktopColors.grisSemiPalido;
    Color colorText = Theme.of(context).primaryColor;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenWidthWithSideBar = screenWidth +
        (screenWidth > 800 ? (widget.sideController.extended ? 50 : 180) : 300);

    void updateList(int value, Politica? politica) {
      setState(() => widget.habitacion.count = value);
      ref
          .read(detectChangeRoomProvider.notifier)
          .update((state) => UniqueKey().hashCode);

      if (politica != null) {
        final habitacionesProvider = HabitacionProvider.provider;
        final typeQuote = ref.watch(typeQuoteProvider);
        int rooms = 0;

        for (var element in habitaciones) {
          if (!element.isFree) rooms += element.count;
        }

        if (!(Preferences.rol == 'RECEPCION')) {
          if (!typeQuote && rooms >= politica.limiteHabitacionCotizacion!) {
            ref.read(typeQuoteProvider.notifier).update((state) => true);
          } else if (typeQuote &&
              rooms < politica.limiteHabitacionCotizacion!) {
            ref.read(typeQuoteProvider.notifier).update((state) => false);
          }
        }

        if (Utility.verifAddRoomFree(
            habitaciones, politica.intervaloHabitacionGratuita!)) {
          ref.read(habitacionesProvider.notifier).addFreeItem(
              widget.habitacion, politica.intervaloHabitacionGratuita!);
        } else if (Utility.verifAddRoomFree(
            habitaciones, politica.intervaloHabitacionGratuita!,
            isReduced: true)) {
          ref.read(habitacionesProvider.notifier).removeFreeItem(
              politica.intervaloHabitacionGratuita!,
              widget.habitacion.folioHabitacion!);
        }
      }
    }

    return Card(
      color: colorCard,
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
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
                        text: Utility.getStringPeriod(
                            initDate:
                                DateTime.parse(widget.habitacion.fechaCheckIn!),
                            lastDate: DateTime.parse(
                                widget.habitacion.fechaCheckOut!)),
                        // "${widget.habitacion.fechaCheckIn} a ${widget.habitacion.fechaCheckOut}",
                        aling: TextAlign.center,
                        color: colorText,
                        size: 12,
                      ),
                    if (screenWidthWithSideBar > 1250)
                      // TextStyles.standardText(
                      //   text: widget.habitacion.adultos!.toString(),
                      //   aling: TextAlign.center,
                      //   color: colorText,
                      //   size: 12,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: NumberInputWithIncrementDecrement(
                          onChanged: (p0) => setState(() =>
                              widget.habitacion.adultos = int.tryParse(p0)),
                          initialValue: widget.habitacion.adultos!.toString(),
                          minimalValue: 1,
                          maxValue: (4 -
                              (int.tryParse(
                                      "${widget.habitacion.menores7a12}") ??
                                  0) -
                              (int.tryParse(
                                      "${widget.habitacion.menores0a6}") ??
                                  0)),
                          colorText: colorText,
                        ),
                      ),
                    if (screenWidthWithSideBar > 1450)
                      // TextStyles.standardText(
                      //   text: widget.habitacion.menores0a6!.toString(),
                      //   aling: TextAlign.center,
                      //   color: colorText,
                      //   size: 12,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: NumberInputWithIncrementDecrement(
                          onChanged: (p0) => setState(() =>
                              widget.habitacion.menores0a6 = int.tryParse(p0)),
                          initialValue:
                              widget.habitacion.menores0a6!.toString(),
                          minimalValue: 0,
                          maxValue: (4 -
                              (int.tryParse(
                                      "${widget.habitacion.menores7a12}") ??
                                  0) -
                              (int.tryParse("${widget.habitacion.adultos}") ??
                                  0)),
                          colorText: colorText,
                        ),
                      ),
                    if (screenWidthWithSideBar > 1350)
                      // TextStyles.standardText(
                      //   text: widget.habitacion.menores7a12!.toString(),
                      //   aling: TextAlign.center,
                      //   color: colorText,
                      //   size: 12,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: NumberInputWithIncrementDecrement(
                          onChanged: (p0) => setState(() =>
                              widget.habitacion.menores7a12 = int.tryParse(p0)),
                          initialValue:
                              (widget.habitacion.menores7a12 ?? 0).toString(),
                          minimalValue: 0,
                          maxValue: (4 -
                              (int.tryParse("${widget.habitacion.adultos}") ??
                                  0) -
                              (int.tryParse(
                                      "${widget.habitacion.menores0a6}") ??
                                  0)),
                          colorText: colorText,
                        ),
                      ),
                    if (screenWidthWithSideBar > 1700)
                      TextStyles.standardText(
                        text: "VR: ${Utility.formatterNumber(typeQuote ? (Utility.calculateTotalTariffRoom(
                              RegistroTarifa(
                                temporadas:
                                    widget.habitacion.tarifaGrupal?.temporadas,
                                tarifas:
                                    widget.habitacion.tarifaGrupal?.tarifas,
                              ),
                              widget.habitacion,
                              widget.habitacion.tarifaXDia!.length,
                              getTotalRoom: true,
                              descuentoProvisional: widget.habitacion
                                  .tarifaGrupal?.descuentoProvisional,
                              onlyTariffVR: true,
                              isGroupTariff: true,
                              withDiscount: false,
                            ) * widget.habitacion.tarifaXDia!.length) : (widget.habitacion.totalRealVR ?? 0))}\nVPM: ${Utility.formatterNumber(typeQuote ? (Utility.calculateTotalTariffRoom(
                              RegistroTarifa(
                                temporadas:
                                    widget.habitacion.tarifaGrupal?.temporadas,
                                tarifas:
                                    widget.habitacion.tarifaGrupal?.tarifas,
                              ),
                              widget.habitacion,
                              widget.habitacion.tarifaXDia!.length,
                              getTotalRoom: true,
                              descuentoProvisional: widget.habitacion
                                  .tarifaGrupal?.descuentoProvisional,
                              onlyTariffVPM: true,
                              isGroupTariff: true,
                              withDiscount: false,
                            ) * widget.habitacion.tarifaXDia!.length) : (widget.habitacion.totalRealVPM ?? 0))}",
                        aling: TextAlign.center,
                        color: colorText,
                        size: 11,
                      ),
                    if (screenWidthWithSideBar > 1550)
                      TextStyles.standardText(
                        text: "VR: ${Utility.formatterNumber(typeQuote ? (Utility.calculateTotalTariffRoom(
                              RegistroTarifa(
                                temporadas:
                                    widget.habitacion.tarifaGrupal?.temporadas,
                                tarifas:
                                    widget.habitacion.tarifaGrupal?.tarifas,
                              ),
                              widget.habitacion,
                              widget.habitacion.tarifaXDia!.length,
                              getTotalRoom: true,
                              descuentoProvisional: widget.habitacion
                                  .tarifaGrupal?.descuentoProvisional,
                              onlyTariffVR: true,
                              isGroupTariff: true,
                              withDiscount: true,
                            ) * widget.habitacion.tarifaXDia!.length) : (widget.habitacion.totalVR ?? 0))}\nVPM: ${Utility.formatterNumber(typeQuote ? (Utility.calculateTotalTariffRoom(
                              RegistroTarifa(
                                temporadas:
                                    widget.habitacion.tarifaGrupal?.temporadas,
                                tarifas:
                                    widget.habitacion.tarifaGrupal?.tarifas,
                              ),
                              widget.habitacion,
                              widget.habitacion.tarifaXDia!.length,
                              getTotalRoom: true,
                              descuentoProvisional: widget.habitacion
                                  .tarifaGrupal?.descuentoProvisional,
                              onlyTariffVPM: true,
                              isGroupTariff: true,
                              withDiscount: true,
                            ) * widget.habitacion.tarifaXDia!.length) : (widget.habitacion.totalVPM ?? 0))}",
                        aling: TextAlign.center,
                        color: colorText,
                        size: 11,
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
                              height: 20,
                              width: 20,
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
                              onPressedDuplicate: widget.onPressedDuplicate,
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
  final void Function()? onPressedDuplicate;
  final bool esDetalle;
  final SidebarXController sideController;

  const _ListTileCotizacion({
    super.key,
    required this.index,
    required this.habitacion,
    required this.onPressedDelete,
    required this.onPressedEdit,
    required this.onPressedDuplicate,
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
    final habitaciones = ref.watch(HabitacionProvider.provider);
    var brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;

    Color colorCard = brightness == Brightness.light
        ? const Color.fromARGB(255, 243, 243, 243)
        : DesktopColors.grisSemiPalido;
    Color? colorText = Theme.of(context).primaryColor;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenWidthWithSideBar = screenWidth +
        (screenWidth > 800 ? (widget.sideController.extended ? 50 : 180) : 50);

    void updateList(int value, Politica? politica) {
      setState(() => widget.habitacion.count = value);
      ref
          .read(detectChangeRoomProvider.notifier)
          .update((state) => UniqueKey().hashCode);

      if (politica != null) {
        final habitacionesProvider = HabitacionProvider.provider;
        final typeQuote = ref.watch(typeQuoteProvider);
        int rooms = 0;

        for (var element in habitaciones) {
          if (!element.isFree) rooms += element.count;
        }

        if (!(Preferences.rol == 'RECEPCION')) {
          if (!typeQuote && rooms >= politica.limiteHabitacionCotizacion!) {
            ref.read(typeQuoteProvider.notifier).update((state) => true);
          } else if (typeQuote &&
              rooms < politica.limiteHabitacionCotizacion!) {
            ref.read(typeQuoteProvider.notifier).update((state) => false);
          }
        }

        if (Utility.verifAddRoomFree(
            habitaciones, politica.intervaloHabitacionGratuita!)) {
          ref.read(habitacionesProvider.notifier).addFreeItem(
              widget.habitacion, politica.intervaloHabitacionGratuita!);
        } else if (Utility.verifAddRoomFree(
            habitaciones, politica.intervaloHabitacionGratuita!,
            isReduced: true)) {
          ref.read(habitacionesProvider.notifier).removeFreeItem(
              politica.intervaloHabitacionGratuita!,
              widget.habitacion.folioHabitacion!);
        }
      }
    }

    return Card(
      elevation: 5,
      color: colorCard,
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
              Utility.getStringPeriod(
                  initDate: DateTime.parse(widget.habitacion.fechaCheckIn!),
                  lastDate: DateTime.parse(widget.habitacion.fechaCheckOut!)),
              //"${widget.habitacion.fechaCheckIn} a ${widget.habitacion.fechaCheckOut}",
              color: colorText,
            ),
            // TextStyles.TextAsociative(
            //   "Tarifa real: ",
            //   Utility.formatterNumber(widget.habitacion.totalRealVR ?? 0),
            //   color: colorText,
            // ),
            // TextStyles.TextAsociative(
            //   (screenWidthWithSideBar < 1100)
            //       ? "Tarifa desc: "
            //       : "Tarifa descontada: ",
            //   Utility.formatterNumber(-(widget.habitacion.descuentoVR ?? 0)),
            //   color: colorText,
            // ),
            TextStyles.TextAsociative(
              (screenWidthWithSideBar < 1100)
                  ? "Tarifa VR:"
                  : "Tarifa Vista Reserva: ",
              Utility.formatterNumber(widget.habitacion.totalVR ?? 0),
              color: colorText,
            ),
            TextStyles.TextAsociative(
              (screenWidthWithSideBar < 1100)
                  ? "Tarifa VPM:"
                  : "Tarifa Vista Parcial Mar: ",
              Utility.formatterNumber(widget.habitacion.totalVPM ?? 0),
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
                  onChanged: (p0) => updateList(
                      (p0.isEmpty || int.parse(p0) < 1) ? 1 : int.parse(p0),
                      data),
                  onDecrement: (p0) {},
                  onIncrement: (p0) {},
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
                  onChanged: (p0) => updateList(
                      (p0.isEmpty || int.parse(p0) < 1) ? 1 : int.parse(p0),
                      data),
                  onDecrement: (p0) {},
                  onIncrement: (p0) {},
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
            onPressedDuplicate: widget.onPressedDuplicate,
            colorIcon: colorText,
          ),
        ),
      ],
    );
  }
}
