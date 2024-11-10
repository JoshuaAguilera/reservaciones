import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/utils/helpers/constants.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/custom_dropdown.dart';
import 'package:generador_formato/widgets/dialogs.dart';

import '../providers/habitacion_provider.dart';
import '../ui/buttons.dart';
import '../ui/custom_widgets.dart';
import '../ui/show_snackbar.dart';
import '../utils/helpers/web_colors.dart';
import 'dynamic_widget.dart';
import 'text_styles.dart';

class SummaryControllerWidget extends ConsumerStatefulWidget {
  const SummaryControllerWidget({
    super.key,
    this.calculateRoom = false,
    this.isLoading = false,
    this.numDays = 0,
    this.onSaveQuote,
    this.saveRooms,
    this.finishQuote = false,
    this.withSaveButton = true,
  });

  final bool calculateRoom;
  final bool isLoading;
  final bool finishQuote;
  final bool withSaveButton;
  final int numDays;
  final void Function()? onSaveQuote;
  final List<Habitacion>? saveRooms;

  @override
  _SummaryControllerWidgetState createState() =>
      _SummaryControllerWidgetState();
}

class _SummaryControllerWidgetState
    extends ConsumerState<SummaryControllerWidget> {
  bool showListVR = true;
  bool showListVPM = true;
  bool showListTotalAdulto = false;
  bool showListTotalMenores = false;
  bool showListDescuentos = false;
  List<TarifaXDia> tarifasFiltradas = [];
  double totalRoom = 0;
  double totalRealRoom = 0;
  double discount = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final listTariffProvider = ref.watch(listTariffDayProvider);
    final listRoomProviderView = ref.watch(listRoomProvider);
    final habitacionProvider = ref.watch(habitacionSelectProvider);
    final habitacionesProvider = ref.watch(HabitacionProvider.provider);

    return SizedBox(
      width: screenWidth < 800 ? 260 : 310,
      height: screenHeight * 0.975,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.calculateRoom ? 18 : 12, vertical: 14),
                  child: listTariffProvider.when(
                    data: (list) {
                      final habitacionProvider =
                          ref.watch(habitacionSelectProvider);
                      tarifasFiltradas = Utility.getUniqueTariffs(list);

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextStyles.standardText(
                            text:
                                "Resumen de ${widget.calculateRoom ? "habitación" : "cotización"}",
                            size: 17,
                            color: Theme.of(context).primaryColor,
                            isBold: true,
                          ),
                          SizedBox(height: widget.calculateRoom ? 2 : 8),
                          Divider(color: Theme.of(context).primaryColor),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  if (!widget.calculateRoom)
                                    listRoomProviderView.when(
                                      data: (data) {
                                        return Column(
                                          children: [
                                            roomExpansionTileList(
                                              showList: showListVR,
                                              habitaciones: widget.finishQuote
                                                  ? widget.saveRooms!
                                                  : habitacionesProvider,
                                              isVR: true,
                                              changeColor: true,
                                              onExpansionChanged: (p0) =>
                                                  setState(
                                                      () => showListVR = p0),
                                            ),
                                            const SizedBox(height: 5),
                                            roomExpansionTileList(
                                              showList: showListVPM,
                                              habitaciones: widget.finishQuote
                                                  ? widget.saveRooms!
                                                  : habitacionesProvider,
                                              isVR: false,
                                              onExpansionChanged: (p0) =>
                                                  setState(
                                                      () => showListVPM = p0),
                                            ),
                                            const SizedBox(height: 5),
                                          ],
                                        );
                                      },
                                      error: (error, stackTrace) =>
                                          TextStyles.standardText(
                                              text:
                                                  "Error de calculación de habitaciones.",
                                              color: Theme.of(context)
                                                  .primaryColor),
                                      loading: () {
                                        return Column(
                                          children: [
                                            roomExpansionTileList(
                                              showList: showListVR,
                                              habitaciones: widget.finishQuote
                                                  ? widget.saveRooms!
                                                  : habitacionesProvider,
                                              isVR: true,
                                              changeColor: true,
                                              onExpansionChanged: (p0) =>
                                                  setState(
                                                      () => showListVR = p0),
                                            ),
                                            const SizedBox(height: 5),
                                            roomExpansionTileList(
                                              showList: showListVPM,
                                              habitaciones: widget.finishQuote
                                                  ? widget.saveRooms!
                                                  : habitacionesProvider,
                                              isVR: false,
                                              onExpansionChanged: (p0) =>
                                                  setState(
                                                      () => showListVPM = p0),
                                            ),
                                            const SizedBox(height: 5),
                                          ],
                                        );
                                      },
                                    )
                                  else
                                    Column(
                                      children: [
                                        CustomWidgets.expansionTileList(
                                          title: "Adultos:",
                                          showList: showListTotalAdulto,
                                          onExpansionChanged: (value) =>
                                              showListTotalAdulto = value,
                                          context: context,
                                          messageNotFound: "Sin tarifas",
                                          total: Utility.calculateTariffTotals(
                                            tarifasFiltradas,
                                            habitacionProvider,
                                            onlyAdults: true,
                                          ),
                                          children: [
                                            for (var element
                                                in tarifasFiltradas)
                                              CustomWidgets.itemListCount(
                                                nameItem:
                                                    "${element.numDays}x ${element.nombreTariff ?? ''}",
                                                subTitle:
                                                    element.subCode != null
                                                        ? '(Mod)'
                                                        : '',
                                                count: Utility
                                                        .calculateTariffAdult(
                                                      element.tarifa == null
                                                          ? null
                                                          : RegistroTarifa(
                                                              tarifas: [
                                                                element.tarifa!
                                                              ],
                                                              temporadas: element
                                                                      .temporadas ??
                                                                  (element.temporadaSelect !=
                                                                          null
                                                                      ? [
                                                                          element
                                                                              .temporadaSelect!
                                                                        ]
                                                                      : []),
                                                            ),
                                                      habitacionProvider,
                                                      widget.numDays,
                                                      withDiscount: false,
                                                    ) *
                                                    element.numDays,
                                                context: context,
                                                sizeText: 11.5,
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        CustomWidgets.expansionTileList(
                                          title: "Menores de 7 a 12:",
                                          showList: showListTotalMenores,
                                          onExpansionChanged: (value) =>
                                              showListTotalMenores = value,
                                          context: context,
                                          messageNotFound: "Sin tarifas",
                                          total: Utility.calculateTariffTotals(
                                            tarifasFiltradas,
                                            habitacionProvider,
                                            onlyChildren: true,
                                          ),
                                          children: [
                                            for (var element
                                                in tarifasFiltradas)
                                              CustomWidgets.itemListCount(
                                                nameItem:
                                                    "${element.numDays}x ${element.nombreTariff ?? ''}",
                                                subTitle:
                                                    element.subCode != null
                                                        ? '(Mod)'
                                                        : '',
                                                count: Utility
                                                        .calculateTariffChildren(
                                                      element.tarifa == null
                                                          ? null
                                                          : RegistroTarifa(
                                                              tarifas: [
                                                                element.tarifa!
                                                              ],
                                                              temporadas: element
                                                                      .temporadas ??
                                                                  (element.temporadaSelect !=
                                                                          null
                                                                      ? [
                                                                          element
                                                                              .temporadaSelect!
                                                                        ]
                                                                      : []),
                                                            ),
                                                      habitacionProvider,
                                                      widget.numDays,
                                                      withDiscount: false,
                                                    ) *
                                                    element.numDays,
                                                context: context,
                                                sizeText: 11.5,
                                              ),
                                          ],
                                        ),
                                        CustomWidgets.itemListCount(
                                          nameItem: "Menores de 0 a 6:",
                                          count: 0,
                                          context: context,
                                        ),
                                        const SizedBox(height: 5),
                                        Divider(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ],
                                    ),
                                  if (widget.calculateRoom)
                                    const SizedBox(height: 5),
                                  if (widget.calculateRoom)
                                    CustomWidgets.itemListCount(
                                      nameItem: "Total:",
                                      count: Utility.calculateTariffTotals(
                                        tarifasFiltradas,
                                        habitacionProvider,
                                        onlyChildren: true,
                                        onlyAdults: true,
                                      ),
                                      context: context,
                                    ),
                                  if (widget.calculateRoom)
                                    const SizedBox(height: 5),
                                  if (widget.calculateRoom)
                                    CustomWidgets.expansionTileList(
                                      title: "Descuento(s):",
                                      showList: showListDescuentos,
                                      onExpansionChanged: (value) =>
                                          showListDescuentos = value,
                                      context: context,
                                      messageNotFound: "Sin descuentos",
                                      total: !widget.calculateRoom
                                          ? -Utility.calculateTotalRooms(
                                              (widget.saveRooms ??
                                                  habitacionesProvider),
                                              onlyDiscount: true,
                                            )
                                          : -(Utility.calculateDiscountTotal(
                                              tarifasFiltradas,
                                              habitacionProvider,
                                              widget.numDays,
                                            )),
                                      children: [
                                        if (widget.calculateRoom)
                                          for (var element in tarifasFiltradas)
                                            CustomWidgets.itemListCount(
                                              nameItem:
                                                  "${element.numDays}x ${element.temporadaSelect?.nombre ?? 'No definido'} (${element.temporadaSelect?.porcentajePromocion ?? element.descuentoProvisional ?? 0}%)",
                                              subTitle: element.subCode != null
                                                  ? '(Mod)'
                                                  : '',
                                              count: (Utility
                                                  .calculateDiscountXTariff(
                                                element,
                                                habitacionProvider,
                                                widget.numDays,
                                              )),
                                              context: context,
                                              sizeText: 11.5,
                                            ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (widget.calculateRoom)
                            Divider(color: Theme.of(context).primaryColor),
                          if (widget.calculateRoom)
                            CustomWidgets.itemListCount(
                              nameItem: "Total cotizado:",
                              count: (Utility.calculateTariffTotals(
                                    tarifasFiltradas,
                                    habitacionProvider,
                                    onlyChildren: true,
                                    onlyAdults: true,
                                  ) -
                                  Utility.calculateDiscountTotal(
                                    tarifasFiltradas,
                                    habitacionProvider,
                                    widget.numDays,
                                  )),
                              context: context,
                              isBold: true,
                              sizeText: 14,
                              height: 40,
                            ),
                        ],
                      );
                    },
                    error: (error, stackTrace) => TextStyles.standardText(
                        text: "Error de calculación de tarifas.",
                        color: Theme.of(context).primaryColor),
                    loading: () => SizedBox(
                      height: screenHeight * 0.7,
                      child: dynamicWidget.loadingWidget(
                        310,
                        screenHeight * 0.2,
                        false,
                        isEstandar: true,
                        message: TextStyles.standardText(
                            text: "Calculando...",
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.withSaveButton)
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: SizedBox(
                  height: 35,
                  child: Buttons.commonButton(
                    sizeText: 15,
                    text: (widget.finishQuote)
                        ? "Nueva Cotización"
                        : (widget.calculateRoom)
                            ? "Guardar Habitación"
                            : "Generar Cotización",
                    color: DesktopColors.ceruleanOscure,
                    isLoading: widget.finishQuote ? false : widget.isLoading,
                    onPressed: () {
                      if (widget.calculateRoom) {
                        saveRoom(habitacionProvider);
                      } else {
                        if (widget.onSaveQuote != null) {
                          widget.onSaveQuote!.call();
                        }
                      }
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool revisedValidTariff(Habitacion habitacion) {
    bool isInvalid = false;

    for (var element in habitacion.tarifaXDia ?? List<TarifaXDia>.empty()) {
      if (element.tarifa == null) {
        isInvalid = true;
        break;
      }
    }

    return isInvalid;
  }

  Widget roomExpansionTileList({
    bool isVR = true,
    required bool showList,
    required List<Habitacion> habitaciones,
    bool changeColor = false,
    required void Function(bool) onExpansionChanged,
  }) {
    List<Habitacion> rooms =
        habitaciones.where((element) => !element.isFree).toList();

    bool showListDescuentosRoom = false;
    bool showListSubtotalRoom = true;

    return StatefulBuilder(builder: (context, snapshot) {
      return CustomWidgets.expansionTileList(
        title: isVR ? "Hab. Vista Reserva:" : "Hab. Vista Parcial al Mar:",
        colorText: (showList) ? null : Colors.white,
        showList: showList,
        showTrailing: !showList,
        collapsedBackgroundColor:
            !isVR ? DesktopColors.vistaParcialMar : DesktopColors.vistaReserva,
        onExpansionChanged: onExpansionChanged,
        context: context,
        messageNotFound: "Sin habitaciones",
        total: Utility.calculateTotalRooms(
          rooms,
          onlyFirstCategory: isVR,
          onlySecoundCategory: !isVR,
          onlyTotalReal: true,
        ),
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: CustomWidgets.expansionTileList(
                  title: "Subtotal:",
                  withTopBorder: true,
                  total: Utility.calculateTotalRooms(
                    (widget.saveRooms ?? rooms),
                    onlyTotalReal: true,
                    onlyFirstCategory: isVR,
                    onlySecoundCategory: !isVR,
                  ),
                  showList: showListSubtotalRoom,
                  onExpansionChanged: (value) =>
                      snapshot(() => showListSubtotalRoom = value),
                  messageNotFound: "Sin habitaciones",
                  context: context,
                  children: [
                    for (var element in rooms)
                      CustomWidgets.itemListCount(
                        nameItem:
                            "${element.count}x Room ${rooms.indexOf(element) + 1}",
                        count: (isVR
                            ? (element.totalRealVR ?? 0)
                            : (element.totalRealVPM ?? 0)),
                        context: context,
                        sizeText: 11.5,
                      )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: CustomWidgets.expansionTileList(
                  title: "Descuento(s):",
                  padding: 0,
                  showList: showListDescuentosRoom,
                  onExpansionChanged: (value) =>
                      snapshot(() => showListDescuentosRoom = value),
                  context: context,
                  messageNotFound: "Sin descuentos",
                  total: -Utility.calculateTotalRooms(
                    (widget.saveRooms ?? habitaciones),
                    onlyDiscount: true,
                    onlyFirstCategory: isVR,
                    onlySecoundCategory: !isVR,
                  ),
                  children: [
                    for (var element in (widget.saveRooms ?? habitaciones)
                        .where((element) => !element.isFree)
                        .toList())
                      CustomWidgets.itemListCount(
                        nameItem:
                            "${element.count}x Room ${(widget.saveRooms ?? habitaciones).where((element) => !element.isFree).toList().indexOf(element) + 1} (Desc.)",
                        count: -((isVR
                                ? element.descuentoVR
                                : element.descuentoVPM) ??
                            0),
                        context: context,
                        sizeText: 11.5,
                      ),
                    for (var element in (widget.saveRooms ?? habitaciones)
                        .where((element) => element.isFree)
                        .toList())
                      CustomWidgets.itemListCount(
                        nameItem:
                            "Room ${(widget.saveRooms ?? habitaciones).where((element) => !element.isFree).toList().indexOf((widget.saveRooms ?? habitaciones).where((element) => !element.isFree).toList().firstWhere((elementInt) => elementInt.folioHabitacion == element.folioHabitacion)) + 1} (Free Room)",
                        count:
                            -((isVR ? element.totalVR : element.totalVPM) ?? 0),
                        context: context,
                        sizeText: 11.5,
                        onChanged: ((widget.saveRooms ?? habitaciones)
                                    .where((element) => !element.isFree)
                                    .toList()
                                    .length <
                                2)
                            ? null
                            : () {
                                if ((widget.saveRooms ?? habitaciones)
                                        .where((element) => !element.isFree)
                                        .toList()
                                        .length <
                                    3) {
                                  ref
                                      .read(
                                          HabitacionProvider.provider.notifier)
                                      .changedFreeRoom(
                                          element.folioHabitacion!);
                                } else {
                                  String selectRoom =
                                      "Room ${(widget.saveRooms ?? habitaciones).where((elementInt) => !elementInt.isFree).toList().indexOf((widget.saveRooms ?? habitaciones).firstWhere((elementInt) => !elementInt.isFree && elementInt.folioHabitacion == element.folioHabitacion)) + 1}";
                                  String changedRoom = selectRoom;

                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        Dialogs.customAlertDialog(
                                      context: context,
                                      title: "Cambiar Habitacion de Cortesía",
                                      iconData: Icons.sync,
                                      iconColor: Colors.green[500],
                                      nameButtonMain: "Aceptar",
                                      contentCustom: Row(children: [
                                        Expanded(
                                          child: TextStyles.standardText(
                                            text: "Aplicar para la habitación:",
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        CustomDropdown.dropdownMenuCustom(
                                            initialSelection: selectRoom,
                                            onSelected: (p0) {
                                              changedRoom = p0!;
                                            },
                                            elements: [
                                              for (var element
                                                  in (widget.saveRooms ??
                                                          habitaciones)
                                                      .where((element) =>
                                                          !element.isFree))
                                                "Room ${(widget.saveRooms ?? habitaciones).where((element) => !element.isFree).toList().indexOf(element) + 1}"
                                            ])
                                      ]),
                                      funtionMain: () {
                                        if (selectRoom == changedRoom) {
                                          return;
                                        }
                                        String result = changedRoom
                                            .replaceFirst("Room ", "");

                                        ref
                                            .read(HabitacionProvider
                                                .provider.notifier)
                                            .changedFreeRoom(
                                                (widget.saveRooms ??
                                                        habitaciones)
                                                    .where((element) =>
                                                        !element.isFree)
                                                    .toList()[
                                                        int.parse(result) - 1]
                                                    .folioHabitacion!,
                                                indexRoom: (widget.saveRooms ??
                                                        habitaciones)
                                                    .indexOf(element));
                                      },
                                      withButtonCancel: false,
                                      colorTextButton:
                                          Theme.of(context).primaryColor,
                                    ),
                                  );
                                }
                              },
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Divider(color: Theme.of(context).primaryColor),
              ),
              CustomWidgets.itemListCount(
                nameItem: "Total:",
                count: Utility.calculateTotalRooms(
                  (widget.saveRooms ?? rooms),
                  onlyTotal: true,
                  onlyFirstCategory: isVR,
                  onlySecoundCategory: !isVR,
                ),
                context: context,
                isBold: true,
                sizeText: 14,
                height: 40,
              ),
            ],
          ),
        ],
      );
    });
  }

  void saveRoom(Habitacion habitacionProvider) {
    if (revisedValidTariff(habitacionProvider)) {
      showSnackBar(
        context: context,
        title: "Dias sin tarifas definidas",
        message:
            "Faltan tarifas para algunos días. Por favor, ingrese los precios para calcular el total de la habitación.",
        type: "danger",
        duration: 3.seconds,
      );
      return;
    }

    habitacionProvider.totalRealVR = Utility.calculateTariffTotals(
      tarifasFiltradas,
      habitacionProvider,
      onlyChildren: true,
      onlyAdults: true,
      onlyTariffVR: true,
    );

    habitacionProvider.descuentoVR = Utility.calculateDiscountTotal(
      tarifasFiltradas,
      habitacionProvider,
      widget.numDays,
      onlyTariffVR: true,
    );

    habitacionProvider.totalVR =
        habitacionProvider.totalRealVR! - habitacionProvider.descuentoVR!;

    habitacionProvider.totalRealVPM = Utility.calculateTariffTotals(
      tarifasFiltradas,
      habitacionProvider,
      onlyChildren: true,
      onlyAdults: true,
      onlyTariffVPM: true,
    );

    habitacionProvider.descuentoVPM = Utility.calculateDiscountTotal(
      tarifasFiltradas,
      habitacionProvider,
      widget.numDays,
      onlyTariffVPM: true,
    );

    habitacionProvider.totalVPM =
        habitacionProvider.totalRealVPM! - habitacionProvider.descuentoVPM!;

    if (widget.onSaveQuote != null) {
      widget.onSaveQuote!.call();
    }
  }
}
