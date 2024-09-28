import 'package:flutter/material.dart';

import '../ui/custom_widgets.dart';
import 'text_styles.dart';

class ControllerCotizacionWidget extends StatefulWidget {
  const ControllerCotizacionWidget({super.key});

  @override
  State<ControllerCotizacionWidget> createState() =>
      _ControllerCotizacionWidgetState();
}

class _ControllerCotizacionWidgetState
    extends State<ControllerCotizacionWidget> {
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
                          text: "Resumen de cotización",
                          size: 17,
                          color: Theme.of(context).primaryColor,
                          isBold: true,
                        ),
                        const SizedBox(height: 8),
                        Divider(color: Theme.of(context).primaryColor),
                        const SizedBox(height: 35),
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
                        const SizedBox(height: 5),
                        CustomWidgets.itemListCount(
                          nameItem: "Total:",
                          count: 0,
                          context: context,
                        ),
                        const SizedBox(height: 5),
                        CustomWidgets.itemListCount(
                          nameItem: "Descuento:",
                          count: -0,
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomWidgets.itemListCount(
                  nameItem: "Total cotizado:",
                  count: 0,
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
