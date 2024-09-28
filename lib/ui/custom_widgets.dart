import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:generador_formato/utils/helpers/utility.dart';

import '../utils/helpers/web_colors.dart';
import '../widgets/form_widgets.dart';
import '../widgets/text_styles.dart';
import '../widgets/textformfield_custom.dart';
import 'buttons.dart';

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

  static Widget sectionConfigSeason({
    required String title,
    required BuildContext context,
    required TextEditingController estanciaController,
    required TextEditingController promocionController,
    void Function(String)? onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: Column(
        children: [
          Center(
            child: TextStyles.mediumText(
              text: title,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SizedBox(
                  child: TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Estancia min.",
                    isNumeric: true,
                    controller: estanciaController,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  child: TextFormFieldCustom.textFormFieldwithBorder(
                    name: "Descuento",
                    isNumeric: true,
                    icon: const Icon(
                      CupertinoIcons.percent,
                      size: 20,
                    ),
                    controller: promocionController,
                    onChanged: (p0) {
                      if (onChanged != null) {
                        onChanged.call(p0);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget expansionTileCustomTarifa({
    required Color colorTarifa,
    required String nameTile,
    required BuildContext context,
    bool initiallyExpanded = false,
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
          initiallyExpanded: initiallyExpanded,
          shape: Border(top: BorderSide(color: colorTarifa)),
          collapsedShape: Border(top: BorderSide(color: colorTarifa)),
          title: TextStyles.standardText(
            text: nameTile,
            isBold: true,
            color: Theme.of(context).primaryColor,
            size: 14,
          ),
          children: [
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
      {double sizeMessage = 11,
      required BuildContext context,
      double sizeImage = 120,
      double? screenWidth,
      bool extended = false}) {
    return SizedBox(
      width: screenWidth != null
          ? (screenWidth > 1280)
              ? (screenWidth - 385 - (extended ? 230 : 118))
              : (screenWidth > 800)
                  ? screenWidth - (extended ? 230 : 118)
                  : screenWidth - 28
          : null,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage("assets/image/not_results.png"),
              width: sizeImage,
              height: sizeImage,
            ),
            TextStyles.standardText(
              text: "No se encontraron resultados",
              size: sizeMessage,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
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
                    listModes[index] =
                        (listModes.where((element) => element).length > 1)
                            ? !listModes[index]
                            : true;
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

  static Widget tableTarifasTemporadas({
    required Color colorBorder,
    required Color backgroundColor,
    required TextEditingController adults1a2,
    required TextEditingController adults3,
    required TextEditingController adults4,
    required TextEditingController paxAdic,
    required TextEditingController minor7a12,
    required TextEditingController promocionController,
    required TextEditingController bar1Controller,
    required TextEditingController bar2Controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder(
                  // horizontalInside: BorderSide(color: colorBorder),
                  verticalInside:
                      BorderSide(color: colorBorder, strokeAlign: 0.5),
                ),
                columnWidths: const {
                  0: FractionColumnWidth(0.22),
                  1: FractionColumnWidth(0.13),
                  2: FractionColumnWidth(0.13),
                  3: FractionColumnWidth(0.13),
                  4: FractionColumnWidth(0.13),
                  5: FractionColumnWidth(0.13),
                  6: FractionColumnWidth(0.13),
                },
                children: [
                  TableRow(
                    children: [
                      SizedBox(
                        height: 25,
                        child: Center(
                          child: SizedBox(
                            child: TextStyles.standardText(
                              text: "PAX",
                              color: useWhiteForeground(backgroundColor)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: TextStyles.standardText(
                          text: "SGL/DBL",
                          color: useWhiteForeground(backgroundColor)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Center(
                        child: TextStyles.standardText(
                          text: "TPL",
                          color: useWhiteForeground(backgroundColor)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Center(
                        child: TextStyles.standardText(
                          text: "CPLE",
                          color: useWhiteForeground(backgroundColor)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Center(
                        child: TextStyles.standardText(
                          text: "MEN 7-12",
                          color: useWhiteForeground(backgroundColor)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Center(
                        child: TextStyles.standardText(
                          text: "PAX ADIC",
                          color: useWhiteForeground(backgroundColor)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Center(
                        child: TextStyles.standardText(
                          text: "MEN 0-6",
                          color: useWhiteForeground(backgroundColor)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget titleFormPage({
    required void Function()? onPressedBack,
    required BuildContext context,
    required String title,
    required void Function()? onPressedSaveButton,
    bool showSaveButton = true,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: showSaveButton
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    if (onPressedBack != null) {
                      onPressedBack.call();
                    }
                  },
                  iconSize: 30,
                  icon: Icon(
                    CupertinoIcons.chevron_left_circle,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
                TextStyles.titlePagText(
                  text: title,
                  overflow: TextOverflow.ellipsis,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            if (showSaveButton)
              SizedBox(
                height: 35,
                width: 130,
                child: Buttons.commonButton(
                  onPressed: () {
                    if (onPressedSaveButton != null) {
                      onPressedSaveButton.call();
                    }
                  },
                  sizeText: 15,
                  text: "Guardar",
                ),
              ),
          ],
        ),
        Divider(color: Theme.of(context).primaryColor),
      ],
    );
  }

  static Widget expansionTileList({
    required String title,
    required bool showList,
    required void Function(bool) onExpansionChanged,
    required BuildContext context,
  }) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.all(4),
      shape: Border.all(color: Colors.transparent),
      initiallyExpanded: showList,
      onExpansionChanged: onExpansionChanged,
      title: Row(
        children: [
          TextStyles.standardText(
            text: title,
            color: Theme.of(context).primaryColor,
            size: 13,
          ),
          Icon(
            showList
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
      trailing: TextStyles.standardText(
        text: Utility.formatterNumber(0),
        color: Theme.of(context).primaryColor,
        size: 13,
      ),
      children: [
        SizedBox(
          height: 35,
          child: Center(
            child: TextStyles.standardText(
              text: "Sin habitaciones",
              color: Theme.of(context).primaryColor,
              size: 11,
            ),
          ),
        ),
      ],
    );
  }

  static Widget itemListCount({
    required String nameItem,
    required double count,
    required BuildContext context,
    bool isBold = false,
    double sizeText = 13,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextStyles.standardText(
              text: nameItem,
              color: Theme.of(context).primaryColor,
              size: sizeText,
              isBold: isBold,
            ),
            TextStyles.standardText(
              text: Utility.formatterNumber(count),
              color: Theme.of(context).primaryColor,
              size: sizeText,
              isBold: isBold,
            ),
          ],
        ),
      ),
    );
  }
}
