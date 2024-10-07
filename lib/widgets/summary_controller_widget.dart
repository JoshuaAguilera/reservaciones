import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generador_formato/models/habitacion_model.dart';
import 'package:generador_formato/models/registro_tarifa_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';

import '../providers/habitacion_provider.dart';
import '../ui/custom_widgets.dart';
import 'text_styles.dart';

class SummaryControllerWidget extends ConsumerStatefulWidget {
  const SummaryControllerWidget({
    super.key,
    this.calculateRoom = false,
    this.totalAdulto = 0,
    this.descuento = 0,
    this.total = 0,
    this.totalMenores = 0,
    this.totalReal = 0,
    this.habitacionVPM,
    this.habitacionesVR,
    this.tarifas,
    this.numDays = 0,
  });

  final bool calculateRoom;
  final double totalAdulto;
  final double totalMenores;
  final double totalReal;
  final double descuento;
  final double total;
  final List<Habitacion>? habitacionesVR;
  final List<Habitacion>? habitacionVPM;
  final List<RegistroTarifa>? tarifas;
  final int numDays;

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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final habitacionProvider = ref.watch(habitacionSelectProvider);

    return SizedBox(
      width: 310,
      height: screenHeight * 0.975,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Column(
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
                                    setState(() => showListVR = value),
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
                                    setState(() => showListVPM = value),
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
                                    setState(() => showListTotalAdulto = value),
                                context: context,
                                messageNotFound: "Sin tarifas",
                                total: widget.totalAdulto,
                                children: [
                                  for (var element in widget.tarifas!)
                                    CustomWidgets.itemListCount(
                                      nameItem:
                                          "${element.numDays}x ${element.nombre ?? ''}",
                                      count: Utility.calculateTariffAdult(
                                            element,
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
                                onExpansionChanged: (value) => setState(
                                    () => showListTotalMenores = value),
                                context: context,
                                messageNotFound: "Sin tarifas",
                                total: widget.totalMenores,
                                children: [
                                  for (var element in widget.tarifas!)
                                    CustomWidgets.itemListCount(
                                      nameItem:
                                          "${element.numDays}x ${element.nombre ?? ''}",
                                      count: Utility.calculateTariffChildren(
                                            element,
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
                              Divider(color: Theme.of(context).primaryColor),
                            ],
                          ),
                        const SizedBox(height: 5),
                        CustomWidgets.itemListCount(
                          nameItem: "Total:",
                          count: widget.totalReal,
                          context: context,
                        ),
                        const SizedBox(height: 5),
                        CustomWidgets.itemListCount(
                          nameItem: "Descuento:",
                          count: -widget.descuento,
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomWidgets.itemListCount(
                  nameItem: "Total cotizado:",
                  count: widget.total,
                  context: context,
                  isBold: true,
                  sizeText: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
