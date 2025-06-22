import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/database/database.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/res/ui/custom_widgets.dart';
import 'package:generador_formato/utils/widgets/form_widgets.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../models/registro_tarifa_model.dart';
import '../../models/tarifa_x_dia_model.dart';
import '../../view-models/providers/habitacion_provider.dart';
import '../../view-models/providers/tarifario_provider.dart';
import '../../res/helpers/desktop_colors.dart';
import '../shared_preferences/settings.dart';
import 'dialogs.dart';
import 'number_input_with_increment_decrement.dart';
import '../../res/ui/text_styles.dart';
import '../../res/helpers/utility.dart';

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
    )
        .animate(target: target)
        .fadeIn(
          duration: Settings.applyAnimations ? null : 0.ms,
        )
        .slideY(
          begin: target < 1 ? 0.15 : -0.15,
          delay: !Settings.applyAnimations ? null : 200.ms,
          duration: Settings.applyAnimations ? null : 0.ms,
        );
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
    // final useCashSeason = ref.watch(useCashSeasonProvider);

    Color colorCard = brightness == Brightness.light
        ? widget.esDetalle
            ? Colors.white
            : const Color.fromARGB(255, 243, 243, 243)
        : DesktopColors.grisSemiPalido;
    Color colorText = Theme.of(context).primaryColor;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenWidthWithSideBar = screenWidth +
        (screenWidth > 800 ? (widget.sideController.extended ? 50 : 180) : 300);

    void updateList(int value, PoliticaTableData? politica) {
      setState(() => widget.habitacion.count = value);
      ref
          .read(detectChangeRoomProvider.notifier)
          .update((state) => UniqueKey().hashCode);

      if (politica != null) {
        final habitacionesProvider = HabitacionProvider.provider;
        final typeQuote = ref.watch(typeQuoteProvider);
        int rooms = 0;

        for (var element in habitaciones) {
          if (!element.esCortesia) rooms += element.count;
        }

        // if (!(Preferences.rol == 'RECEPCION')) {
        if (!typeQuote && rooms >= politica.limiteHabitacionCotizacion!) {
          ref.read(typeQuoteProvider.notifier).update((state) => true);
        } else if (typeQuote && rooms < politica.limiteHabitacionCotizacion!) {
          ref.read(typeQuoteProvider.notifier).update((state) => false);
        }
        // }

        if (Utility.verifAddRoomFree(
            habitaciones, politica.intervaloHabitacionGratuita!)) {
          ref.read(habitacionesProvider.notifier).addFreeItem(
              widget.habitacion, politica.intervaloHabitacionGratuita!);
        } else if (Utility.verifAddRoomFree(
            habitaciones, politica.intervaloHabitacionGratuita!,
            isReduced: true)) {
          ref.read(habitacionesProvider.notifier).removeFreeItem(
              politica.intervaloHabitacionGratuita!,
              widget.habitacion.id!);
        }
      }
    }

    void _recalculateTotals() {
      widget.habitacion.totalRealVR =
          _getTotalRoom(room: widget.habitacion, withDiscount: false);
      widget.habitacion.totalRealVPM = _getTotalRoom(
          room: widget.habitacion, withDiscount: false, onlyTariffVR: false);
      widget.habitacion.totalVR = _getTotalRoom(room: widget.habitacion);
      widget.habitacion.totalVPM =
          _getTotalRoom(room: widget.habitacion, onlyTariffVR: false);

      widget.habitacion.descuentoVR =
          _getTotalRoom(room: widget.habitacion, onlyDiscount: true);
      widget.habitacion.descuentoVPM = _getTotalRoom(
          room: widget.habitacion, onlyTariffVR: false, onlyDiscount: true);

      ref
          .read(detectChangeRoomProvider.notifier)
          .update((state) => UniqueKey().hashCode);
    }

    return Card(
      color: colorCard,
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: const FractionColumnWidth(0.075),
                if (screenWidthWithSideBar < 1250 &&
                    screenWidthWithSideBar > 1000)
                  1: const FractionColumnWidth(0.13),
                if (screenWidthWithSideBar > 1250)
                  1: const FractionColumnWidth(0.12),
                if (screenWidthWithSideBar < 1550 &&
                    screenWidthWithSideBar > 1300)
                  2: const FractionColumnWidth(0.2),
                if (screenWidthWithSideBar < 1550 &&
                    screenWidthWithSideBar > 1400)
                  3: const FractionColumnWidth(0.2),
                if (screenWidthWithSideBar < 1550 &&
                    screenWidthWithSideBar > 1500)
                  4: const FractionColumnWidth(0.2),
                if (screenWidthWithSideBar < 1200)
                  4: const FractionColumnWidth(0.3),
                if (screenWidthWithSideBar < 1300)
                  5: const FractionColumnWidth(0.25)
              },
              border: const TableBorder(
                  horizontalInside: BorderSide(color: Colors.black87)),
              children: [
                TableRow(
                  children: [
                    TextStyles.standardText(
                      text: (widget.index + 1).toString(),
                      align: TextAlign.center,
                      overClip: true,
                      color: colorText,
                      size: 12,
                    ),
                    if (screenWidthWithSideBar > 950)
                      TextStyles.standardText(
                        text: Utility.getStringPeriod(
                          initDate:
                              DateTime.parse(widget.habitacion.checkIn!),
                          lastDate:
                              DateTime.parse(widget.habitacion.checkOut!),
                        ),
                        align: TextAlign.center,
                        color: colorText,
                        size: 12,
                      ),
                    if (screenWidthWithSideBar > 1000)
                      widget.esDetalle
                          ? TextStyles.standardText(
                              text: (widget.habitacion.adultos ?? 0).toString(),
                              align: TextAlign.center,
                              color: colorText,
                              size: 12,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: SizedBox(
                                height: 50,
                                child: NumberInputWithIncrementDecrement(
                                  onChanged: (p0) {
                                    widget.habitacion.adultos =
                                        int.tryParse(p0);
                                    _recalculateTotals();
                                    setState(() {});
                                  },
                                  initialValue:
                                      widget.habitacion.adultos!.toString(),
                                  minimalValue: 1,
                                  height: 6,
                                  sizeIcons: 18,
                                  maxValue: (4 -
                                      (widget.habitacion.menores7a12 ?? 0) -
                                      (widget.habitacion.menores0a6 ?? 0)),
                                  colorText: colorText,
                                ),
                              ),
                            ),
                    if (screenWidthWithSideBar > 1200)
                      widget.esDetalle
                          ? TextStyles.standardText(
                              text: (widget.habitacion.menores0a6 ?? 0)
                                  .toString(),
                              align: TextAlign.center,
                              color: colorText,
                              size: 12,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: SizedBox(
                                height: 50,
                                child: NumberInputWithIncrementDecrement(
                                  onChanged: (p0) {
                                    widget.habitacion.menores0a6 =
                                        int.tryParse(p0);
                                    _recalculateTotals();
                                    setState(() {});
                                  },
                                  initialValue:
                                      widget.habitacion.menores0a6!.toString(),
                                  minimalValue: 0,
                                  height: 6,
                                  sizeIcons: 18,
                                  maxValue: (4 -
                                      (widget.habitacion.menores7a12 ?? 0) -
                                      (widget.habitacion.adultos ?? 0)),
                                  colorText: colorText,
                                ),
                              ),
                            ),
                    if (screenWidthWithSideBar > 1100)
                      widget.esDetalle
                          ? TextStyles.standardText(
                              text: (widget.habitacion.menores7a12 ?? 0)
                                  .toString(),
                              align: TextAlign.center,
                              color: colorText,
                              size: 12,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: SizedBox(
                                height: 50,
                                child: NumberInputWithIncrementDecrement(
                                  onChanged: (p0) {
                                    widget.habitacion.menores7a12 =
                                        int.tryParse(p0);
                                    _recalculateTotals();
                                    setState(() {});
                                  },
                                  initialValue:
                                      (widget.habitacion.menores7a12 ?? 0)
                                          .toString(),
                                  minimalValue: 0,
                                  height: 6,
                                  sizeIcons: 18,
                                  maxValue: (4 -
                                      (widget.habitacion.adultos ?? 0) -
                                      (widget.habitacion.menores0a6 ?? 0)),
                                  colorText: colorText,
                                ),
                              ),
                            ),
                    if (screenWidthWithSideBar > 1700)
                      TextStyles.standardText(
                        text:
                            "VR: ${Utility.formatterNumber(widget.esDetalle ? (widget.habitacion.totalRealVR ?? 0) : (typeQuote) ? _getTotalRoomGroup(room: widget.habitacion, withDiscount: false) : (widget.habitacion.totalRealVR ?? 0))}"
                            "\nVPM: ${Utility.formatterNumber(widget.esDetalle ? (widget.habitacion.totalRealVPM ?? 0) : typeQuote ? _getTotalRoomGroup(room: widget.habitacion, withDiscount: false, onlyTariffVR: false) : (widget.habitacion.totalRealVPM ?? 0))}",
                        align: TextAlign.center,
                        color: colorText,
                        size: 11,
                      ),
                    if (screenWidthWithSideBar > 1550)
                      TextStyles.standardText(
                        text:
                            "VR: ${Utility.formatterNumber(widget.esDetalle ? (widget.habitacion.totalVR ?? 0) : typeQuote ? _getTotalRoomGroup(room: widget.habitacion) : (widget.habitacion.totalVR ?? 0))}"
                            "\nVPM: ${Utility.formatterNumber(widget.esDetalle ? (widget.habitacion.totalVPM ?? 0) : typeQuote ? _getTotalRoomGroup(room: widget.habitacion, onlyTariffVR: false) : (widget.habitacion.totalVPM ?? 0))}",
                        align: TextAlign.center,
                        color: colorText,
                        size: 11,
                      ),
                    if (!widget.esDetalle && !widget.habitacion.esCortesia)
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
                        align: TextAlign.center,
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

double _getTotalRoomGroup({
  required Habitacion room,
  bool onlyTariffVR = true,
  bool withDiscount = true,
}) {
  double totalGroup = Utility.calculateTotalTariffRoom(
    RegistroTarifa(
      temporadas: room.tarifaGrupal?.temporadas,
      tarifas: room.tarifaGrupal?.tarifas,
    ),
    room,
    room.tarifaXHabitacion!.length,
    getTotalRoom: true,
    descuentoProvisional: room.tarifaGrupal?.descuentoProvisional,
    onlyTariffVR: onlyTariffVR,
    onlyTariffVPM: !onlyTariffVR,
    isGroupTariff: true,
    withDiscount: withDiscount,
    applyRoundFormat: !(room.tarifaGrupal?.modificado ?? false),
  );

  return (totalGroup * room.tarifaXHabitacion!.length);
}

double _getTotalRoom({
  required Habitacion room,
  bool onlyTariffVR = true,
  bool withDiscount = true,
  bool onlyDiscount = false,
}) {
  List<TarifaXDia> tarifasFiltradas =
      Utility.getUniqueTariffs(room.tarifaXHabitacion ?? []);

  double discount = !withDiscount
      ? 0
      : Utility.calculateDiscountTotal(
          tarifasFiltradas,
          room,
          room.tarifaXHabitacion?.length ?? 0,
          typeQuote: false,
          onlyTariffVR: onlyTariffVR,
          onlyTariffVPM: !onlyTariffVR,
        );

  if (onlyDiscount) {
    return discount;
  }

  double total = Utility.calculateTariffTotals(
        tarifasFiltradas,
        room,
        onlyChildren: true,
        onlyAdults: true,
        onlyTariffVR: onlyTariffVR,
        onlyTariffVPM: !onlyTariffVR,
      ) -
      (discount);

  return total;
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
    final typeQuote = ref.watch(typeQuoteProvider);

    Color colorCard = brightness == Brightness.light
        ? const Color.fromARGB(255, 243, 243, 243)
        : DesktopColors.grisSemiPalido;
    Color? colorText = Theme.of(context).primaryColor;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenWidthWithSideBar = screenWidth +
        (screenWidth > 800 ? (widget.sideController.extended ? 50 : 180) : 50);

    void updateList(int value, PoliticaTableData? politica) {
      setState(() => widget.habitacion.count = value);
      ref
          .read(detectChangeRoomProvider.notifier)
          .update((state) => UniqueKey().hashCode);

      if (politica != null) {
        final habitacionesProvider = HabitacionProvider.provider;
        final typeQuote = ref.watch(typeQuoteProvider);
        int rooms = 0;

        for (var element in habitaciones) {
          if (!element.esCortesia) rooms += element.count;
        }

        // if (!(Preferences.rol == 'RECEPCION')) {
        if (!typeQuote && rooms >= politica.limiteHabitacionCotizacion!) {
          ref.read(typeQuoteProvider.notifier).update((state) => true);
        } else if (typeQuote && rooms < politica.limiteHabitacionCotizacion!) {
          ref.read(typeQuoteProvider.notifier).update((state) => false);
        }
        // }

        if (Utility.verifAddRoomFree(
            habitaciones, politica.intervaloHabitacionGratuita!)) {
          ref.read(habitacionesProvider.notifier).addFreeItem(
              widget.habitacion, politica.intervaloHabitacionGratuita!);
        } else if (Utility.verifAddRoomFree(
            habitaciones, politica.intervaloHabitacionGratuita!,
            isReduced: true)) {
          ref.read(habitacionesProvider.notifier).removeFreeItem(
              politica.intervaloHabitacionGratuita!,
              widget.habitacion.id!);
        }
      }
    }

    void _recalculateTotals() {
      widget.habitacion.totalRealVR =
          _getTotalRoom(room: widget.habitacion, withDiscount: false);
      widget.habitacion.totalRealVPM = _getTotalRoom(
          room: widget.habitacion, withDiscount: false, onlyTariffVR: false);
      widget.habitacion.totalVR = _getTotalRoom(room: widget.habitacion);
      widget.habitacion.totalVPM =
          _getTotalRoom(room: widget.habitacion, onlyTariffVR: false);

      widget.habitacion.descuentoVR =
          _getTotalRoom(room: widget.habitacion, onlyDiscount: true);
      widget.habitacion.descuentoVPM = _getTotalRoom(
          room: widget.habitacion, onlyTariffVR: false, onlyDiscount: true);

      ref
          .read(detectChangeRoomProvider.notifier)
          .update((state) => UniqueKey().hashCode);
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
        title: TextStyles.TextAsociative(
          (screenWidthWithSideBar < 1100) ? "Fechas: " : "Fechas de estancia: ",
          Utility.getStringPeriod(
              initDate: DateTime.parse(widget.habitacion.checkIn!),
              lastDate: DateTime.parse(widget.habitacion.checkOut!)),
          color: colorText,
          size: 13.5,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            const SizedBox(height: 2.5),
            Wrap(
              spacing: 12,
              runSpacing: 5,
              children: [
                TextStyles.TextAsociative(
                  (screenWidthWithSideBar < 1100)
                      ? "Tarifa VR: "
                      : "Tarifa Vista Reserva: ",
                  Utility.formatterNumber(widget.esDetalle
                      ? (widget.habitacion.totalVR ?? 0)
                      : typeQuote
                          ? _getTotalRoomGroup(room: widget.habitacion)
                          : (widget.habitacion.totalVR ?? 0)),
                  color: colorText,
                ),
                TextStyles.TextAsociative(
                  (screenWidthWithSideBar < 1100)
                      ? "Tarifa VPM: "
                      : "Tarifa Vista Parcial Mar: ",
                  Utility.formatterNumber(widget.esDetalle
                      ? (widget.habitacion.totalVPM ?? 0)
                      : typeQuote
                          ? _getTotalRoomGroup(
                              room: widget.habitacion, onlyTariffVR: false)
                          : (widget.habitacion.totalVPM ?? 0)),
                  color: colorText,
                ),
              ],
            ),
            Wrap(
              spacing: 15,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: widget.esDetalle ? 30 : 145,
                  height: widget.esDetalle ? 15 : 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextStyles.TextAsociative(
                        (screenWidthWithSideBar < 900) ? 'Ad: ' : 'Adultos:',
                        "${widget.esDetalle ? widget.habitacion.adultos : ""}",
                        color: colorText,
                        boldInversed: widget.esDetalle,
                      ),
                      if (!widget.esDetalle)
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: NumberInputWithIncrementDecrement(
                            onChanged: (p0) {
                              widget.habitacion.adultos = int.tryParse(p0);
                              _recalculateTotals();
                              setState(() {});
                            },
                            initialValue: widget.habitacion.adultos!.toString(),
                            minimalValue: 1,
                            height: 6,
                            sizeIcons: 20,
                            maxValue: (4 -
                                (widget.habitacion.menores7a12 ?? 0) -
                                (widget.habitacion.menores0a6 ?? 0)),
                            colorText: colorText,
                            inHorizontal: true,
                          ),
                        )
                    ],
                  ),
                ),
                SizedBox(
                  width: widget.esDetalle ? 40 : 175,
                  height: widget.esDetalle ? 15 : 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextStyles.TextAsociative(
                        (screenWidthWithSideBar < 900)
                            ? '0-6: '
                            : 'Menores 0-6:',
                        "${widget.esDetalle ? widget.habitacion.menores0a6 : ""}",
                        color: colorText,
                        boldInversed: widget.esDetalle,
                      ),
                      if (!widget.esDetalle)
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: SizedBox(
                            child: NumberInputWithIncrementDecrement(
                              onChanged: (p0) {
                                widget.habitacion.menores0a6 = int.tryParse(p0);
                                _recalculateTotals();
                                setState(() {});
                              },
                              initialValue:
                                  widget.habitacion.menores0a6!.toString(),
                              minimalValue: 0,
                              height: 6,
                              sizeIcons: 20,
                              maxValue: (4 -
                                  (widget.habitacion.menores7a12 ?? 0) -
                                  (widget.habitacion.adultos ?? 0)),
                              colorText: colorText,
                              inHorizontal: true,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                SizedBox(
                  width: widget.esDetalle ? 40 : 180,
                  height: widget.esDetalle ? 15 : 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextStyles.TextAsociative(
                        (screenWidthWithSideBar < 900)
                            ? '7-12: '
                            : 'Menores 7-12:',
                        "${widget.esDetalle ? widget.habitacion.menores7a12 : ""}",
                        color: colorText,
                        boldInversed: widget.esDetalle,
                      ),
                      if (!widget.esDetalle)
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: NumberInputWithIncrementDecrement(
                            onChanged: (p0) {
                              widget.habitacion.menores7a12 = int.tryParse(p0);
                              _recalculateTotals();
                              setState(() {});
                            },
                            initialValue:
                                (widget.habitacion.menores7a12 ?? 0).toString(),
                            minimalValue: 0,
                            height: 6,
                            sizeIcons: 18,
                            maxValue: (4 -
                                (widget.habitacion.adultos ?? 0) -
                                (widget.habitacion.menores0a6 ?? 0)),
                            colorText: colorText,
                            inHorizontal: true,
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
            if (widget.esDetalle)
              TextStyles.TextAsociative(
                'Cantidad:',
                " ${widget.habitacion.count} Rooms",
                color: colorText,
                boldInversed: true,
              ),
            const SizedBox(height: 5),
            if (screenWidthWithSideBar < 1100 && !(widget.esDetalle))
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
