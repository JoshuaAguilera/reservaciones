import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/utils/helpers/utility.dart';

import '../utils/helpers/web_colors.dart';
import '../widgets/form_widgets.dart';
import '../widgets/text_styles.dart';
import '../widgets/textformfield_custom.dart';

class CustomWidgets {
  static Widget containerCard(
      {required List<Widget> children, MainAxisAlignment? maxAlignment}) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: maxAlignment ?? MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }

  static Widget expansionTileCustomTarifa({
    required Color colorTarifa,
    required String nameTile,
    required BuildContext context,
    required TextEditingController estanciaController,
    required TextEditingController promocionController,
    required TextEditingController adults1_2Controller,
    required TextEditingController paxAdicController,
    required TextEditingController adults3Controller,
    required TextEditingController adults4Controller,
    required TextEditingController minors7_12Controller,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: StatefulBuilder(builder: (context, snapshot) {
        return ExpansionTile(
          initiallyExpanded: true,
          shape: Border(top: BorderSide(color: colorTarifa)),
          collapsedShape: Border(top: BorderSide(color: colorTarifa)),
          title: TextStyles.standardText(
            text: nameTile,
            isBold: true,
            color: Theme.of(context).primaryColor,
            size: 14,
          ),
          children: [
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: TextFormFieldCustom.textFormFieldwithBorder(
                      name: "Estancia min.",
                      isNumeric: true,
                      controller: promocionController,
                      onChanged: (p0) {
                        if (onChanged != null) {
                          onChanged.call(p0);
                        }
                        snapshot(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: TextFormFieldCustom.textFormFieldwithBorder(
                      name: "Descuento",
                      isNumeric: true,
                      icon: const Icon(CupertinoIcons.percent),
                      controller: promocionController,
                      onChanged: (p0) {
                        if (onChanged != null) {
                          onChanged.call(p0);
                        }
                        snapshot(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Opacity(
              opacity: 0.5,
              child: Row(
                children: [
                  Expanded(
                    child: FormWidgets.textFormFieldResizable(
                      name: "SGL/DBL",
                      isDecimal: true,
                      isNumeric: true,
                      isMoneda: true,
                      controller: TextEditingController(
                          text: Utility.calculatePromotion(
                              adults1_2Controller, promocionController, 0)),
                      blocked: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FormWidgets.textFormFieldResizable(
                      name: "PAX ADIC",
                      isDecimal: true,
                      isNumeric: true,
                      isMoneda: true,
                      controller: TextEditingController(
                          text: Utility.calculatePromotion(
                              paxAdicController, promocionController, 0)),
                      blocked: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Opacity(
              opacity: 0.5,
              child: Row(
                children: [
                  Expanded(
                    child: FormWidgets.textFormFieldResizable(
                      name: "TPL",
                      isDecimal: true,
                      isNumeric: true,
                      isMoneda: true,
                      blocked: true,
                      controller: TextEditingController(
                        text: Utility.calculatePromotion(
                          adults3Controller,
                          promocionController,
                          0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FormWidgets.textFormFieldResizable(
                      name: "CPLE",
                      isDecimal: true,
                      isNumeric: true,
                      isMoneda: true,
                      blocked: true,
                      controller: TextEditingController(
                        text: Utility.calculatePromotion(
                          adults4Controller,
                          promocionController,
                          0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Opacity(
              opacity: 0.5,
              child: Row(
                children: [
                  Expanded(
                    child: FormWidgets.textFormFieldResizable(
                      name: "MENORES 7 A 12 AÑOS",
                      isDecimal: true,
                      isNumeric: true,
                      isMoneda: true,
                      blocked: true,
                      controller: TextEditingController(
                        text: Utility.calculatePromotion(
                          minors7_12Controller,
                          promocionController,
                          0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FormWidgets.textFormFieldResizable(
                      name: "MENORES 0 A 6 AÑOS",
                      isDecimal: true,
                      initialValue: "GRATIS",
                      isNumeric: true,
                      blocked: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  static Widget messageNotResult(
      {double sizeMessage = 11, required BuildContext context}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("assets/image/not_results.png"),
            width: 120,
            height: 120,
          ),
          TextStyles.standardText(
            text: "No se encontraron resultados",
            size: sizeMessage,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  static Widget sectionButton({
    required List<bool> listModes,
    required List<Widget> modesVisual,
    void Function(int, int)? onChanged,
    List<String>? arrayStrings,
    Color? selectedColor,
    Color? selectedBorderColor,
    double borderRadius = 4,
    bool isCompact = false,
    bool isReactive = true,
  }) {
    return StatefulBuilder(
      builder: (context, snapshot) {
        return Align(
          alignment: Alignment.centerRight,
          child: ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              snapshot(
                () {
                  if (isReactive) {
                    for (int i = 0; i < listModes.length; i++) {
                      listModes[i] = i == index;
                      onChanged!.call(i, index);
                    }
                  } else {
                    listModes[index] = !listModes[index];
                    onChanged!.call(0, index);
                  }
                },
              );
            },
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            selectedBorderColor: selectedBorderColor ?? DesktopColors.cerulean,
            selectedColor: DesktopColors.ceruleanOscure,
            fillColor: selectedColor,
            color: Theme.of(context).primaryColor,
            constraints: isCompact
                ? null
                : const BoxConstraints(minHeight: 35.0, minWidth: 70.0),
            isSelected: listModes,
            children: modesVisual.isEmpty
                ? Utility.generateTextWidget(
                    arrayStrings!, Theme.of(context).primaryColor)
                : modesVisual,
          ),
        );
      },
    );
  }
}
