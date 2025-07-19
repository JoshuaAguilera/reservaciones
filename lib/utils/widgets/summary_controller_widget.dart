import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/categoria_model.dart';
import '../../models/habitacion_model.dart';
import '../../models/tarifa_rack_model.dart';
import '../../models/tarifa_x_habitacion_model.dart';
import '../../res/helpers/calculator_helpers.dart';
import '../../res/helpers/colors_helpers.dart';
import '../../res/helpers/utility.dart';
import '../../view-models/providers/habitacion_provider.dart';
import '../../view-models/providers/tarifario_provider.dart';
import '../../res/ui/buttons.dart';
import '../../res/ui/custom_widgets.dart';
import '../../res/ui/show_snackbar.dart';
import '../../res/helpers/desktop_colors.dart';
import 'dynamic_widget.dart';
import '../../res/ui/text_styles.dart';

class SummaryControllerWidget extends ConsumerStatefulWidget {
  const SummaryControllerWidget({
    super.key,
    this.calculateRoom = false,
    this.isLoading = false,
    this.numDays = 0,
    this.onSaveQuote,
    this.onCancel,
    this.saveRooms,
    this.finishQuote = false,
    this.withSaveButton = true,
    this.showCancel = false,
  });

  final bool calculateRoom;
  final bool isLoading;
  final bool finishQuote;
  final bool withSaveButton;
  final bool showCancel;
  final int numDays;
  final void Function()? onSaveQuote;
  final void Function()? onCancel;
  final List<Habitacion>? saveRooms;

  @override
  ConsumerState<SummaryControllerWidget> createState() =>
      _SummaryControllerWidgetState();
}

class _SummaryControllerWidgetState
    extends ConsumerState<SummaryControllerWidget> {
  bool showListVR = true;
  bool showListVPM = true;
  bool showListTotalAdulto = false;
  bool showListTotalMenores = false;
  bool showListDescuentos = false;
  List<TarifaXHabitacion> tarifasFiltradas = [];
  late Categoria categoria;
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
    final typeQuote = ref.watch(typeQuoteProvider);
    final useCashSeason = ref.watch(useCashSeasonProvider);
    final politicaTarifaProvider = ref.watch(listPolicyProvider(""));

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
                                                  ? widget.saveRooms ?? []
                                                  : habitacionesProvider,
                                              isVR: true,
                                              changeColor: true,
                                              onExpansionChanged: (p0) =>
                                                  setState(
                                                      () => showListVR = p0),
                                              typeQuote: typeQuote,
                                            ),
                                            const SizedBox(height: 5),
                                            roomExpansionTileList(
                                              showList: showListVPM,
                                              habitaciones: widget.finishQuote
                                                  ? widget.saveRooms ?? []
                                                  : habitacionesProvider,
                                              isVR: false,
                                              onExpansionChanged: (p0) =>
                                                  setState(
                                                      () => showListVPM = p0),
                                              typeQuote: typeQuote,
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
                                                  ? widget.saveRooms ?? []
                                                  : habitacionesProvider,
                                              isVR: true,
                                              changeColor: true,
                                              onExpansionChanged: (p0) =>
                                                  setState(
                                                      () => showListVR = p0),
                                              typeQuote: typeQuote,
                                            ),
                                            const SizedBox(height: 5),
                                            roomExpansionTileList(
                                              showList: showListVPM,
                                              habitaciones: widget.finishQuote
                                                  ? widget.saveRooms ?? []
                                                  : habitacionesProvider,
                                              isVR: false,
                                              onExpansionChanged: (p0) =>
                                                  setState(
                                                      () => showListVPM = p0),
                                              typeQuote: typeQuote,
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
                                          total:
                                              CalculatorHelpers.getTariffTotals(
                                            tarifasFiltradas,
                                            habitacionProvider,
                                            categoria,
                                            onlyAdults: true,
                                          ),
                                          children: [
                                            for (var element
                                                in tarifasFiltradas)
                                              CustomWidgets.itemListCount(
                                                nameItem:
                                                    "${element.numDays}x ${element.tarifaXDia?.tarifaRack?.nombre ?? ''}",
                                                subTitle:
                                                    element.subcode != null
                                                        ? '(Mod)'
                                                        : '',
                                                count: CalculatorHelpers
                                                    .getTotalCategoryRoom(
                                                  TarifaRack(
                                                    registros: element
                                                        .tarifaXDia
                                                        ?.tarifaRack
                                                        ?.registros,
                                                    temporadas: element
                                                            .tarifaXDia
                                                            ?.tarifaRack
                                                            ?.temporadas ??
                                                        (element.tarifaXDia
                                                                    ?.temporadaSelect !=
                                                                null
                                                            ? [
                                                                // element
                                                                //     .tarifaXDia
                                                                //     .temporadaSelect!
                                                              ]
                                                            : []),
                                                  ),
                                                  habitacionProvider,
                                                  categoria,
                                                  widget.numDays,
                                                  withDiscount: false,
                                                  applyRoundFormat: !(element
                                                          .tarifaXDia
                                                          ?.modificado ??
                                                      false),
                                                ),
                                                context: context,
                                                sizeText: 11.5,
                                                color: element.tarifaXDia
                                                    ?.tarifaRack?.color,
                                                height: 45,
                                                paddingBottom: 7,
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
                                          total:
                                              CalculatorHelpers.getTariffTotals(
                                            tarifasFiltradas,
                                            habitacionProvider,
                                            categoria,
                                            onlyChildren: true,
                                          ),
                                          children: [
                                            for (var element
                                                in tarifasFiltradas)
                                              CustomWidgets.itemListCount(
                                                nameItem:
                                                    "${element.numDays}x ${element.tarifaXDia?.tarifaRack?.nombre ?? ''}",
                                                subTitle:
                                                    element.subcode != null
                                                        ? '(Mod)'
                                                        : '',
                                                count: CalculatorHelpers
                                                    .getTotalCategoryRoom(
                                                  TarifaRack(
                                                    registros: element
                                                        .tarifaXDia
                                                        ?.tarifaRack
                                                        ?.registros,
                                                    temporadas: element
                                                            .tarifaXDia
                                                            ?.tarifaRack
                                                            ?.temporadas ??
                                                        (element.tarifaXDia
                                                                    ?.temporadaSelect !=
                                                                null
                                                            ? [
                                                                // element
                                                                //     .tarifaXDia!
                                                                //     .temporadaSelect!
                                                              ]
                                                            : []),
                                                  ),
                                                  habitacionProvider,
                                                  categoria,
                                                  widget.numDays,
                                                  applyRoundFormat: !(element
                                                          .tarifaXDia
                                                          ?.modificado ??
                                                      false),
                                                  withDiscount: false,
                                                  isCalculateChildren: true,
                                                ),
                                                context: context,
                                                sizeText: 11.5,
                                                color: element.tarifaXDia
                                                    ?.tarifaRack?.color,
                                                height: 45,
                                                paddingBottom: 7,
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
                                      count: CalculatorHelpers.getTariffTotals(
                                        tarifasFiltradas,
                                        habitacionProvider,
                                        categoria,
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
                                      total: -(CalculatorHelpers
                                          .calculateDiscountTotal(
                                        tarifasFiltradas,
                                        habitacionProvider,
                                        categoria,
                                        widget.numDays,
                                        typeQuote: typeQuote,
                                      )),
                                      children: [
                                        if (widget.calculateRoom)
                                          for (var element in tarifasFiltradas)
                                            CustomWidgets.itemListCount(
                                              nameItem:
                                                  "${element.numDays}x ${element.tarifaXDia?.temporadaSelect?.nombre ?? (element.id == "tariffFree" ? 'Tarifa Libre' : 'No definido')} (${element.tarifaXDia?.temporadaSelect?.descuento ?? element.tarifaXDia?.descIntegrado ?? 0}%)",
                                              subTitle: element.subcode != null
                                                  ? '(Mod)'
                                                  : '',
                                              count: -(CalculatorHelpers
                                                  .calculateDiscountXTariff(
                                                element,
                                                habitacionProvider,
                                                categoria,
                                                widget.numDays,
                                                onlyDiscountUnitary: true,
                                                typeQuote: typeQuote,
                                                useCashTariff: useCashSeason,
                                                applyRoundFormatt: !(element
                                                        .tarifaXDia
                                                        ?.modificado ??
                                                    false),
                                              )),
                                              context: context,
                                              sizeText: 11.5,
                                              color: element.tarifaXDia
                                                  ?.tarifaRack?.color,
                                              height: 45,
                                              paddingBottom: 7,
                                            ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (widget.calculateRoom)
                            Divider(color: Theme.of(context).primaryColor),
                          if (!widget.calculateRoom &&
                              widget.withSaveButton &&
                              !(widget.finishQuote))
                            politicaTarifaProvider.when(
                              data: (data) => Card(
                                color: typeQuote == "grupal"
                                    ? DesktopColors.cotGrupal
                                    : DesktopColors.cotIndiv,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextStyles.standardText(
                                        text: "Vigencia:",
                                        size: 12,
                                        color: typeQuote == "individual"
                                            ? DesktopColors.azulUltClaro
                                            : DesktopColors.prussianBlue,
                                      ),
                                      // TextStyles.standardText(
                                      //   text: DateHelpers.getStringDate(
                                      //     data: DateTime.now().add(
                                      //       Duration(
                                      //         days: (typeQuote)
                                      //             ? data?.diasVigenciaCotGroup ??
                                      //                 0
                                      //             : data?.diasVigenciaCotInd ??
                                      //                 0,
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   size: 12,
                                      //   isBold: true,
                                      //   color: !typeQuote
                                      //       ? DesktopColors.azulUltClaro
                                      //       : DesktopColors.prussianBlue,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              error: (error, stackTrace) => const Tooltip(
                                message: "Error de consulta",
                                child: Icon(Icons.warning_amber_rounded,
                                    color: Colors.amber),
                              ),
                              loading: () => const SizedBox(),
                            ),
                          if (widget.calculateRoom)
                            CustomWidgets.itemListCount(
                              nameItem: "Total cotizado:",
                              count: (CalculatorHelpers.getTariffTotals(
                                    tarifasFiltradas,
                                    habitacionProvider,
                                    categoria,
                                    onlyChildren: true,
                                    onlyAdults: true,
                                  ) -
                                  CalculatorHelpers.calculateDiscountTotal(
                                    tarifasFiltradas,
                                    habitacionProvider,
                                    categoria,
                                    widget.numDays,
                                    typeQuote: typeQuote,
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
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 35,
                        child: Buttons.commonButton(
                          sizeText: 12.5,
                          compact: true,
                          text: (widget.finishQuote)
                              ? "Nueva Cotización"
                              : (widget.calculateRoom)
                                  ? "Guardar Habitación"
                                  : "Generar Cotización",
                          color: DesktopColors.ceruleanOscure,
                          isLoading:
                              widget.finishQuote ? false : widget.isLoading,
                          onPressed: () {
                            if (widget.calculateRoom) {
                              saveRoom(
                                  habitacionProvider, typeQuote, useCashSeason);
                            } else {
                              widget.onSaveQuote?.call();
                            }
                          },
                        ),
                      ),
                    ),
                    if (widget.showCancel)
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 35,
                          child: Buttons.commonButton(
                            sizeText: 12.5,
                            compact: true,
                            text: "Cancelar",
                            color: ColorsHelpers.darken(
                                DesktopColors.cerulean, -0.05),
                            onPressed:
                                (widget.finishQuote ? false : widget.isLoading)
                                    ? null
                                    : () {
                                        widget.onCancel?.call();
                                      },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool revisedValidTariff(Habitacion habitacion) {
    bool isInvalid = false;

    for (var element
        in habitacion.tarifasXHabitacion ?? List<TarifaXHabitacion>.empty()) {
      // if (element.tarifa == null) {
      //   isInvalid = true;
      //   break;
      // }
    }

    return isInvalid;
  }

  Widget roomExpansionTileList({
    bool isVR = true,
    required bool showList,
    required List<Habitacion> habitaciones,
    bool changeColor = false,
    required void Function(bool) onExpansionChanged,
    String typeQuote = "individual",
  }) {
    List<Habitacion> rooms =
        habitaciones.where((element) => !element.esCortesia).toList();

    bool showListDescuentosRoom = false;
    bool showListSubtotalRoom = false;

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
        total: CalculatorHelpers.getTotalRooms(
          (widget.saveRooms ?? rooms),
          categoria,
          onlyTotal: true,
          tipoCotizacion: typeQuote,
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
                  total: CalculatorHelpers.getTotalRooms(
                    (widget.saveRooms ?? rooms),
                    categoria,
                    tipoCotizacion: typeQuote,
                    onlyTotalReal: true,
                  ),
                  showList: showListSubtotalRoom,
                  onExpansionChanged: (value) =>
                      snapshot(() => showListSubtotalRoom = value),
                  messageNotFound: "Sin habitaciones",
                  context: context,
                  children: [
                    // for (var element in rooms)
                    //   CustomWidgets.itemListCount(
                    //     nameItem:
                    //         "${element.count}x Room ${rooms.indexOf(element) + 1}",
                    //     count: (CalculatorHelpers.getTotalCategoryRoom(
                    //           RegistroTarifa(
                    //             temporadas: element.tarifaGrupal?.temporadas,
                    //             tarifas: element.tarifaGrupal?.tarifas,
                    //           ),
                    //           element,
                    //           element.tarifasXHabitacion!.length,
                    //           getTotalRoom: true,
                    //           descuentoProvisional:
                    //               element.tarifaGrupal?.descuentoProvisional,
                    //           onlyTariffVR: isVR,
                    //           onlyTariffVPM: !isVR,
                    //           isGroupTariff: true,
                    //           withDiscount: false,
                    //           applyRoundFormat:
                    //               !(element.tarifaGrupal?.modificado ?? false),
                    //         ) *
                    //         element.tarifasXHabitacion!.length),
                    //     context: context,
                    //     sizeText: 11.5,
                    //   )
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
                  total: -CalculatorHelpers.getTotalRooms(
                    (widget.saveRooms ?? habitaciones),
                    categoria,
                    onlyDiscount: true,
                    tipoCotizacion: typeQuote,
                  ),
                  children: [
                    // for (var element in (widget.saveRooms ?? habitaciones)
                    //     .where((element) => !element.esCortesia)
                    //     .toList())
                    //   CustomWidgets.itemListCount(
                    //     nameItem:
                    //         "${element.count}x Room ${(widget.saveRooms ?? habitaciones).where((element) => !element.esCortesia).toList().indexOf(element) + 1} (${element.tarifaGrupal?.temporadaSelect?.porcentajePromocion ?? element.tarifaGrupal?.descuentoProvisional ?? 0}%)",
                    //     count: typeQuote
                    //         ? -Utility.calculateDiscountTotal(
                    //             [element.tarifaGrupal ?? TarifaXDia()],
                    //             element,
                    //             element.tarifasXHabitacion?.length ?? 0,
                    //             typeQuote: typeQuote,
                    //             onlyTariffVR: isVR,
                    //             onlyTariffVPM: !isVR,
                    //             applyRoundFormatt:
                    //                 !(element.tarifaGrupal?.modificado ??
                    //                     false),
                    //           )
                    //         : -((isVR
                    //                 ? element.descuentoVR
                    //                 : element.descuentoVPM) ??
                    //             0),
                    //     context: context,
                    //     sizeText: 11.5,
                    //   ),
                    // for (var element in (widget.saveRooms ?? habitaciones)
                    //     .where((element) => element.esCortesia)
                    //     .toList())
                    //   CustomWidgets.itemListCount(
                    //     nameItem:
                    //         "Room ${(widget.saveRooms ?? habitaciones).where((element) => !element.esCortesia).toList().indexOf((widget.saveRooms ?? habitaciones).where((element) => !element.esCortesia).toList().firstWhere((elementInt) => elementInt.id == element.id)) + 1} (Cortesía)",
                    //     count: typeQuote
                    //         ? -(Utility.calculateTotalTariffRoom(
                    //               RegistroTarifa(
                    //                 temporadas:
                    //                     element.tarifaGrupal?.temporadas,
                    //                 tarifas: element.tarifaGrupal?.tarifas,
                    //               ),
                    //               element,
                    //               element.tarifasXHabitacion!.length,
                    //               getTotalRoom: true,
                    //               descuentoProvisional: element
                    //                   .tarifaGrupal?.descuentoProvisional,
                    //               onlyTariffVR: isVR,
                    //               onlyTariffVPM: !isVR,
                    //               isGroupTariff: true,
                    //               applyRoundFormat:
                    //                   !(element.tarifaGrupal?.modificado ??
                    //                       false),
                    //             ) *
                    //             element.tarifasXHabitacion!.length)
                    //         : -((isVR ? element.totalVR : element.totalVPM) ??
                    //             0),
                    //     context: context,
                    //     color: Colors.green[300],
                    //     sizeText: 11.5,
                    //     onChanged: ((widget.saveRooms ?? habitaciones)
                    //                 .where((element) => !element.esCortesia)
                    //                 .toList()
                    //                 .length <
                    //             2)
                    //         ? null
                    //         : () {
                    //             if ((widget.saveRooms ?? habitaciones)
                    //                     .where((element) => !element.esCortesia)
                    //                     .toList()
                    //                     .length <
                    //                 3) {
                    //               ref
                    //                   .read(
                    //                       HabitacionProvider.provider.notifier)
                    //                   .changedFreeRoom(element.id!);
                    //             } else {
                    //               String selectRoom =
                    //                   "Room ${(widget.saveRooms ?? habitaciones).where((elementInt) => !elementInt.esCortesia).toList().indexOf((widget.saveRooms ?? habitaciones).firstWhere((elementInt) => !elementInt.esCortesia && elementInt.id == element.id)) + 1}";
                    //               String changedRoom = selectRoom;

                    //               showDialog(
                    //                 context: context,
                    //                 builder: (context) =>
                    //                     Dialogs.customAlertDialog(
                    //                   context: context,
                    //                   title: "Cambiar Habitacion de Cortesía",
                    //                   iconData: Icons.sync,
                    //                   iconColor: Colors.green[500],
                    //                   nameButtonMain: "Aceptar",
                    //                   contentCustom: Row(children: [
                    //                     Expanded(
                    //                       child: TextStyles.standardText(
                    //                         text: "Aplicar para la habitación:",
                    //                         color:
                    //                             Theme.of(context).primaryColor,
                    //                       ),
                    //                     ),
                    //                     CustomDropdown.dropdownMenuCustom(
                    //                         initialSelection: selectRoom,
                    //                         onSelected: (p0) {
                    //                           changedRoom = p0!;
                    //                         },
                    //                         elements: [
                    //                           for (var element
                    //                               in (widget.saveRooms ??
                    //                                       habitaciones)
                    //                                   .where((element) =>
                    //                                       !element.esCortesia))
                    //                             "Room ${(widget.saveRooms ?? habitaciones).where((element) => !element.esCortesia).toList().indexOf(element) + 1}"
                    //                         ])
                    //                   ]),
                    //                   funtionMain: () {
                    //                     if (selectRoom == changedRoom) {
                    //                       return;
                    //                     }
                    //                     String result = changedRoom
                    //                         .replaceFirst("Room ", "");

                    //                     ref
                    //                         .read(HabitacionProvider
                    //                             .provider.notifier)
                    //                         .changedFreeRoom(
                    //                             (widget.saveRooms ??
                    //                                     habitaciones)
                    //                                 .where((element) =>
                    //                                     !element.esCortesia)
                    //                                 .toList()[
                    //                                     int.parse(result) - 1]
                    //                                 .id!,
                    //                             indexRoom: (widget.saveRooms ??
                    //                                     habitaciones)
                    //                                 .indexOf(element));
                    //                   },
                    //                   withButtonCancel: false,
                    //                   colorTextButton:
                    //                       Theme.of(context).primaryColor,
                    //                 ),
                    //               );
                    //             }
                    //           },
                    //   ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Divider(color: Theme.of(context).primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: CustomWidgets.itemListCount(
                  nameItem: "Total:",
                  count: CalculatorHelpers.getTotalRooms(
                    (widget.saveRooms ?? habitaciones),
                    categoria,
                    onlyTotal: true,
                    tipoCotizacion: typeQuote,
                  ),
                  context: context,
                  isBold: true,
                  sizeText: 14,
                  height: 40,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  void saveRoom(
      Habitacion habitacionProvider, String typeQuote, bool useCashSeason) {
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

    // habitacionProvider.totalRealVR = Utility.calculateTariffTotals(
    //   tarifasFiltradas,
    //   habitacionProvider,
    //   onlyChildren: true,
    //   onlyAdults: true,
    //   onlyTariffVR: true,
    // );

    // habitacionProvider.descuentoVR = Utility.calculateDiscountTotal(
    //   tarifasFiltradas,
    //   habitacionProvider,
    //   widget.numDays,
    //   onlyTariffVR: true,
    //   typeQuote: typeQuote,
    // );

    // habitacionProvider.totalVR =
    //     habitacionProvider.totalRealVR! - habitacionProvider.descuentoVR!;

    // habitacionProvider.totalRealVPM = Utility.calculateTariffTotals(
    //   tarifasFiltradas,
    //   habitacionProvider,
    //   onlyChildren: true,
    //   onlyAdults: true,
    //   onlyTariffVPM: true,
    // );

    // habitacionProvider.descuentoVPM = Utility.calculateDiscountTotal(
    //   tarifasFiltradas,
    //   habitacionProvider,
    //   widget.numDays,
    //   onlyTariffVPM: true,
    //   typeQuote: typeQuote,
    // );

    // habitacionProvider.totalVPM =
    //     habitacionProvider.totalRealVPM! - habitacionProvider.descuentoVPM!;

    widget.onSaveQuote?.call();
  }
}
