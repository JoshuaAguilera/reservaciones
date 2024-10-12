import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/models/tarifa_x_dia_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';

import '../providers/habitacion_provider.dart';
import '../ui/buttons.dart';
import '../ui/custom_widgets.dart';
import '../ui/show_snackbar.dart';
import 'dynamic_widget.dart';
import 'text_styles.dart';

class SummaryControllerWidget extends ConsumerStatefulWidget {
  const SummaryControllerWidget({
    super.key,
    this.calculateRoom = false,
    this.numDays = 0,
    this.onPressed,
  });

  final bool calculateRoom;
  final int numDays;
  final void Function()? onPressed;

  @override
  _SummaryControllerWidgetState createState() =>
      _SummaryControllerWidgetState();
}

class _SummaryControllerWidgetState
    extends ConsumerState<SummaryControllerWidget> {
  bool showListVR = false;
  bool showListVPM = false;
  bool showListTotalAdulto = false;
  bool showListTotalMenores = false;
  bool showListDescuentos = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final listTariffProvider = ref.watch(listTariffDayProvider);
    final habitacionProvider = ref.watch(habitacionSelectProvider);

    return SizedBox(
      width: 310,
      height: screenHeight * 0.975,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: listTariffProvider.when(
                    data: (list) {
                      final habitacionProvider =
                          ref.watch(habitacionSelectProvider);
                      List<TarifaXDia> tarifasFiltradas =
                          Utility.getUniqueTariffs(list);

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
                                  const SizedBox(height: 35),
                                  if (!widget.calculateRoom)
                                    Column(
                                      children: [
                                        CustomWidgets.expansionTileList(
                                          title: "Hab. Vista Reserva:",
                                          showList: showListVR,
                                          onExpansionChanged: (value) =>
                                              setState(
                                                  () => showListVR = value),
                                          context: context,
                                          messageNotFound: "Sin habitaciones",
                                          total: 0,
                                          children: [],
                                        ),
                                        const SizedBox(height: 5),
                                        CustomWidgets.expansionTileList(
                                          title: "Hab. Vista Parcial al Mar:",
                                          showList: showListVPM,
                                          onExpansionChanged: (value) =>
                                              setState(
                                                  () => showListVPM = value),
                                          context: context,
                                          messageNotFound: "Sin habitaciones",
                                          total: 0,
                                          children: [],
                                        ),
                                      ],
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
                                          total: calculateTariffTotals(
                                            tarifasFiltradas,
                                            habitacionProvider,
                                            onlyAdults: true,
                                          ),
                                          children: [
                                            for (var element
                                                in tarifasFiltradas)
                                              CustomWidgets.itemListCount(
                                                nameItem:
                                                    "${element.numDays}x ${element.nombreTarif ?? ''}",
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
                                          total: calculateTariffTotals(
                                            tarifasFiltradas,
                                            habitacionProvider,
                                            onlyChildren: true,
                                          ),
                                          children: [
                                            for (var element
                                                in tarifasFiltradas)
                                              CustomWidgets.itemListCount(
                                                nameItem:
                                                    "${element.numDays}x ${element.nombreTarif ?? ''}",
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
                                  const SizedBox(height: 5),
                                  CustomWidgets.itemListCount(
                                    nameItem: "Total:",
                                    count: calculateTariffTotals(
                                      tarifasFiltradas,
                                      habitacionProvider,
                                      onlyChildren: true,
                                      onlyAdults: true,
                                    ),
                                    context: context,
                                  ),
                                  const SizedBox(height: 5),
                                  CustomWidgets.expansionTileList(
                                    title: "Descuento(s):",
                                    showList: showListDescuentos,
                                    onExpansionChanged: (value) =>
                                        showListDescuentos = value,
                                    context: context,
                                    messageNotFound: "Sin descuentos",
                                    total: -calculateDiscountTotal(
                                        tarifasFiltradas, habitacionProvider),
                                    children: [
                                      for (var element in tarifasFiltradas)
                                        CustomWidgets.itemListCount(
                                          nameItem:
                                              "${element.numDays}x ${element.temporadaSelect?.nombre ?? 'No definida'} (${element.temporadaSelect?.porcentajePromocion ?? element.descuentoProvisional ?? 0}%)",
                                          subTitle: element.subCode != null
                                              ? '(Mod)'
                                              : '',
                                          count: (calculateDiscountXTariff(
                                              element, habitacionProvider)),
                                          context: context,
                                          sizeText: 11.5,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: Theme.of(context).primaryColor),
                          CustomWidgets.itemListCount(
                            nameItem: "Total cotizado:",
                            count: calculateTariffTotals(
                                  tarifasFiltradas,
                                  habitacionProvider,
                                  onlyChildren: true,
                                  onlyAdults: true,
                                ) -
                                calculateDiscountTotal(
                                    tarifasFiltradas, habitacionProvider),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: SizedBox(
                height: 35,
                child: Buttons.commonButton(
                  onPressed: () {
                    if (revisedValidTariff(habitacionProvider)) {
                      showSnackBar(
                        context: context,
                        title: "Dias sin tarifas definidas",
                        message:
                            "Faltan tarifas para algunos días. Por favor, ingrese los precios para calcular el total de la habitación.",
                        type: "danger",
                        duration: 6.seconds,
                      );
                      return;
                    }

                    if (widget.onPressed != null) {
                      widget.onPressed!.call();
                    }
                  },
                  sizeText: 15,
                  text: "Guardar Habitación",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTariffTotals(
      List<TarifaXDia> tarifasFiltradas, Habitacion habitacion,
      {bool onlyAdults = false,
      bool onlyChildren = false,
      bool getDiscount = false}) {
    double total = 0;

    for (var element in tarifasFiltradas) {
      if (onlyAdults) {
        switch (habitacion.adultos) {
          case 1 || 2:
            total +=
                (element.tarifa?.tarifaAdultoSGLoDBL ?? 0) * element.numDays;
            break;
          case 3:
            total += (element.tarifa?.tarifaAdultoTPL ?? 0) * element.numDays;
            break;
          case 4:
            total += (element.tarifa?.tarifaAdultoCPLE ?? 0) * element.numDays;
            break;
          default:
            total += 0;
        }
      }

      if (onlyChildren) {
        total += ((element.tarifa?.tarifaMenores7a12 ?? 0) * element.numDays) *
            (habitacion.menores7a12 ?? 0);
      }
    }

    return total;
  }

  double calculateDiscountTotal(
      List<TarifaXDia> tarifasFiltradas, Habitacion habitacion) {
    double discountTotal = 0;

    for (var element in tarifasFiltradas) {
      discountTotal += calculateDiscountXTariff(element, habitacion);
    }

    return discountTotal;
  }

  double calculateDiscountXTariff(TarifaXDia element, Habitacion habitacion) {
    double discount = 0;

    double totalAdults = Utility.calculateTariffAdult(
      element.tarifa == null
          ? null
          : RegistroTarifa(
              tarifas: [element.tarifa!],
              temporadas: element.temporadas ??
                  (element.temporadaSelect != null
                      ? [element.temporadaSelect!]
                      : []),
            ),
      habitacion,
      widget.numDays,
      withDiscount: false,
    );
    double totalChildren = Utility.calculateTariffChildren(
      element.tarifa == null
          ? null
          : RegistroTarifa(
              tarifas: [element.tarifa!],
              temporadas: element.temporadas ??
                  (element.temporadaSelect != null
                      ? [element.temporadaSelect!]
                      : []),
            ),
      habitacion,
      widget.numDays,
      withDiscount: false,
    );

    double total = totalChildren + totalAdults;

    if (element.temporadaSelect != null) {
      discount =
          (total * 0.01) * (element.temporadaSelect?.porcentajePromocion ?? 0);
    } else {
      discount = (total * 0.01) * (element.descuentoProvisional ?? 0);
    }

    return (discount.round() * element.numDays) + 0.0;
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
}
