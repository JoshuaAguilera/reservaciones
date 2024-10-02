import 'package:flutter/material.dart';
import 'package:generador_formato/models/habitacion_model.dart';

import '../ui/custom_widgets.dart';
import 'text_styles.dart';

class CalculateSummaryControllerWidget extends StatefulWidget {
  const CalculateSummaryControllerWidget({
    super.key,
    this.calculateRoom = false,
    this.totalAdulto = 0,
    this.descuento = 0,
    this.total = 0,
    this.totalMenores = 0,
    this.totalReal = 0,
    this.habitacionVPM,
    this.habitacionesVR,
  });

  final bool calculateRoom;
  final double totalAdulto;
  final double totalMenores;
  final double totalReal;
  final double descuento;
  final double total;
  final List<Habitacion>? habitacionesVR;
  final List<Habitacion>? habitacionVPM;

  @override
  State<CalculateSummaryControllerWidget> createState() =>
      _CalculateSummaryControllerWidgetState();
}

class _CalculateSummaryControllerWidgetState
    extends State<CalculateSummaryControllerWidget> {
  bool showListVR = false;
  bool showListVPM = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: 310,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: screenHeight - 120,
                  child: SingleChildScrollView(
                    child: Column(
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
                              ),
                              const SizedBox(height: 5),
                              CustomWidgets.expansionTileList(
                                title: "Hab. Vista Parcial al Mar:",
                                showList: showListVPM,
                                onExpansionChanged: (value) =>
                                    setState(() => showListVPM = value),
                                context: context,
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              CustomWidgets.itemListCount(
                                nameItem: "Adultos:",
                                count: widget.totalAdulto,
                                context: context,
                              ),
                              const SizedBox(height: 5),
                              CustomWidgets.itemListCount(
                                nameItem: "Menores de 7 a 12:",
                                count: widget.totalMenores,
                                context: context,
                              ),
                              const SizedBox(height: 5),
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
