import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/models/temporada_model.dart';
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
    required BuildContext context,
    required Temporada temporada,
    void Function()? onRemove,
    void Function(String)? onChangedEstancia,
    void Function(String)? onChangedDescuento,
    void Function(String)? onChangedName,
  }) {
    bool editName = false;
    TextEditingController _controller =
        TextEditingController(text: temporada.nombre);

    return StatefulBuilder(builder: (context, snapshot) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 23, right: 21),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Theme.of(context).primaryColor)),
              child: Column(
                children: [
                  if (!editName)
                    SizedBox(
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextStyles.mediumText(
                              text: temporada.nombre ?? '',
                              color: Theme.of(context).primaryColor,
                              overflow: TextOverflow.ellipsis),
                          if (temporada.editable!)
                            Expanded(
                              child: SizedBox(
                                height: 30,
                                width: 35,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                      onPressed: () =>
                                          snapshot(() => editName = !editName),
                                      icon: Icon(Icons.edit,
                                          size: 22,
                                          color:
                                              Theme.of(context).dividerColor)),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (editName)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: SizedBox(
                        height: 40,
                        child: FormWidgets.textFormFieldResizable(
                          name: "",
                          controller: _controller,
                          onEditingComplete: () {
                            snapshot(
                              () {
                                onChangedName!.call(_controller.text);
                                editName = false;
                              },
                            );
                          },
                          icon: IconButton(
                            onPressed: () => snapshot(() {
                              editName = !editName;
                              _controller.text = temporada.nombre ?? '';
                            }),
                            icon: Icon(
                              CupertinoIcons.clear_circled,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: TextFormFieldCustom.textFormFieldwithBorder(
                            name: "Estancia min.",
                            isNumeric: true,
                            icon: const Icon(CupertinoIcons.person_3_fill),
                            initialValue: temporada.estanciaMinima?.toString(),
                            onChanged: (p0) {
                              onChangedEstancia!.call(p0);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          child: TextFormFieldCustom.textFormFieldwithBorder(
                            name: "Descuento",
                            isNumeric: true,
                            initialValue:
                                temporada.porcentajePromocion?.toString(),
                            icon: const Icon(
                              CupertinoIcons.percent,
                              size: 20,
                            ),
                            onChanged: (p0) {
                              onChangedDescuento!.call(p0);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (temporada.editable!)
            Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                child: IconButton(
                  onPressed: onRemove,
                  icon: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    size: 25,
                    color: DesktopColors.cerulean,
                  ),
                ),
              ),
            )
        ],
      );
    });
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
    required BuildContext context,
    required String tipoHabitacion,
    required Color? colorTipo,
    required List<Temporada> temporadas,
    required TextEditingController adults1a2,
    required TextEditingController adults3,
    required TextEditingController adults4,
    required TextEditingController paxAdic,
    required TextEditingController minor7a12,
  }) {
    return Card(
      elevation: 8,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 35,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 25),
              decoration: BoxDecoration(
                  color: colorTipo,
                  borderRadius: const BorderRadius.all(Radius.circular(7))),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextStyles.mediumText(
                  text: tipoHabitacion,
                  color: Colors.white,
                  aling: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Table(
              border: TableBorder(
                top: BorderSide(color: Theme.of(context).primaryColor),
                bottom: BorderSide(color: Theme.of(context).primaryColor),
                horizontalInside:
                    BorderSide(color: Theme.of(context).primaryColor),
              ),
              columnWidths: const {0: FractionColumnWidth(0.3)},
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: TextStyles.mediumText(
                          text: "Temporada",
                          color: Theme.of(context).primaryColor,
                          aling: TextAlign.center,
                        ),
                      ),
                    ),
                    Center(
                      child: TextStyles.mediumText(
                        text: "SGL/DBL",
                        color: Theme.of(context).primaryColor,
                        aling: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: TextStyles.mediumText(
                        text: "TPL",
                        color: Theme.of(context).primaryColor,
                        aling: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: TextStyles.mediumText(
                        text: "CPLE",
                        color: Theme.of(context).primaryColor,
                        aling: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: TextStyles.mediumText(
                        text: "PAX ADIC",
                        color: Theme.of(context).primaryColor,
                        aling: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: TextStyles.mediumText(
                        text: "MENORES 7 A 12",
                        color: Theme.of(context).primaryColor,
                        size: 10,
                        aling: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: TextStyles.mediumText(
                        text: "MENORES 0 A 6",
                        color: Theme.of(context).primaryColor,
                        size: 10,
                        aling: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                for (var element in temporadas)
                  TableRow(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Center(
                            child: TextStyles.mediumText(
                          text: element.nombre ?? '',
                          color: Theme.of(context).primaryColor,
                          aling: TextAlign.center,
                        )),
                      ),
                      Center(
                          child: TextStyles.mediumText(
                        text: (adults1a2.text.isEmpty &&
                                element.porcentajePromocion == null)
                            ? "—"
                            : Utility.calculatePromotion(
                                adults1a2,
                                TextEditingController(
                                    text: element.porcentajePromocion
                                        ?.toString()),
                                0),
                        color: Theme.of(context).primaryColor,
                        aling: TextAlign.center,
                      )),
                      Center(
                          child: TextStyles.mediumText(
                        text: ((adults3.text.isEmpty || adults3.text == '0') &&
                                element.porcentajePromocion == null)
                            ? "—"
                            : Utility.calculatePromotion(
                                adults3,
                                TextEditingController(
                                    text: element.porcentajePromocion
                                        ?.toString()),
                                0),
                        color: Theme.of(context).primaryColor,
                        aling: TextAlign.center,
                      )),
                      Center(
                        child: TextStyles.mediumText(
                          text:
                              ((adults4.text.isEmpty || adults4.text == '0') &&
                                      element.porcentajePromocion == null)
                                  ? "—"
                                  : Utility.calculatePromotion(
                                      adults4,
                                      TextEditingController(
                                          text: element.porcentajePromocion
                                              ?.toString()),
                                      0),
                          color: Theme.of(context).primaryColor,
                          aling: TextAlign.center,
                        ),
                      ),
                      Center(
                          child: TextStyles.mediumText(
                        text: (paxAdic.text.isEmpty &&
                                element.porcentajePromocion == null)
                            ? "—"
                            : Utility.calculatePromotion(
                                paxAdic,
                                TextEditingController(
                                    text: element.porcentajePromocion
                                        ?.toString()),
                                0),
                        color: Theme.of(context).primaryColor,
                        aling: TextAlign.center,
                      )),
                      Center(
                        child: TextStyles.mediumText(
                          text: (minor7a12.text.isEmpty &&
                                  element.porcentajePromocion == null)
                              ? "—"
                              : Utility.calculatePromotion(
                                  minor7a12,
                                  TextEditingController(
                                      text: element.porcentajePromocion
                                          ?.toString()),
                                  0),
                          color: Theme.of(context).primaryColor,
                          aling: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: TextStyles.mediumText(
                          text: "GRATIS",
                          color: Theme.of(context).primaryColor,
                          aling: TextAlign.center,
                        ),
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
            Expanded(
              child: Row(
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
                  Expanded(
                    child: TextStyles.titlePagText(
                      text: title,
                      overflow: TextOverflow.ellipsis,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
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
    required String messageNotFound,
    required double total,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.all(4),
      shape: Border(top: BorderSide(color: Theme.of(context).primaryColor)),
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
        text: Utility.formatterNumber(total),
        color: Theme.of(context).primaryColor,
        size: 13,
      ),
      children: children.isNotEmpty
          ? children
          : [
              SizedBox(
                height: 35,
                child: Center(
                  child: TextStyles.standardText(
                    text: messageNotFound,
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
    double height = 60,
    String subTitle = '',
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextStyles.standardText(
                text: nameItem,
                color: Theme.of(context).primaryColor,
                size: sizeText,
                isBold: isBold,
              ),
            ),
            if (subTitle.isNotEmpty)
              SizedBox(
                width: 40,
                child: TextStyles.standardText(
                  text: subTitle,
                  size: sizeText,
                  color: Theme.of(context).primaryColor,
                  isBold: true,
                ),
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
