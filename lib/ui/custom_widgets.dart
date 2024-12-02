import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:generador_formato/models/tarifa_model.dart';
import 'package:generador_formato/models/temporada_model.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/views/tarifario/manager_cash_tariff_dialog.dart';
import 'package:generador_formato/widgets/table_rows.dart';
import 'package:icons_plus/icons_plus.dart';

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
    void Function(bool)? onChangedUseTariff,
    void Function(List<Tarifa>)? onChangedTariffs,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 32,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  child: TextStyles.mediumText(
                                    text: temporada.nombre ?? '',
                                    color: Theme.of(context).primaryColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (temporada.editable!)
                                  Expanded(
                                    child: SizedBox(
                                      height: 30,
                                      width: 35,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: IconButton(
                                          onPressed: () => snapshot(
                                              () => editName = !editName),
                                          icon: Icon(
                                            HeroIcons.pencil_square,
                                            size: 22,
                                            color:
                                                Theme.of(context).dividerColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        if (temporada.forCash ?? false)
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 32,
                                child: FormWidgets.inputSwitch(
                                  compact:
                                      MediaQuery.of(context).size.width < 950,
                                  name: "Usar tarifas",
                                  value: temporada.useTariff ?? false,
                                  activeColor: Theme.of(context).dividerColor,
                                  context: context,
                                  onChanged: (p0) =>
                                      onChangedUseTariff?.call(p0),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (editName)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: SizedBox(
                        height: 40,
                        child: Focus(
                          onFocusChange: (value) {
                            if (!value) {
                              snapshot(() => editName = false);
                            }
                          },
                          child: FormWidgets.textFormFieldResizable(
                            name: "",
                            autofocus: true,
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
                      if (!(temporada.forCash ?? false) ||
                          (temporada.useTariff ?? false))
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
                        )
                      else
                        Expanded(
                          child: SizedBox(
                            height: 49,
                            child: Buttons.commonButton(
                              icons: HeroIcons.clipboard_document_list,
                              child: TextStyles.standardText(
                                  text: "Administrar Tarifa",
                                  aling: TextAlign.center),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ManagerCashTariffDialog(
                                      temporada: temporada),
                                ).then(
                                  (value) {
                                    if (value != null) {
                                      if (onChangedTariffs != null) {
                                        onChangedTariffs
                                            .call(value as List<Tarifa>);
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  )
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

  static Widget messageNotResult({
    double sizeMessage = 11,
    required BuildContext context,
    double sizeImage = 120,
    double? screenWidth,
    bool extended = false,
    String message = "No se encontraron resultados",
  }) {
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
              text: message,
              size: sizeMessage,
              color: Theme.of(context).primaryColor,
              aling: TextAlign.center,
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
            Table(
              border: TableBorder(
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
                        text: "MENORES 7 A 12",
                        color: Theme.of(context).primaryColor,
                        size: 10,
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
                        text: "MENORES 0 A 6",
                        color: Theme.of(context).primaryColor,
                        size: 10,
                        aling: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                for (var element in temporadas)
                  TableRows.tarifasTemporadaTableRow(
                    context,
                    element: element,
                    adults1a2: adults1a2,
                    adults3: adults3,
                    adults4: adults4,
                    paxAdic: paxAdic,
                    minor7a12: minor7a12,
                    isGroup: element.forGroup ?? false,
                    isCash: element.forCash ?? false,
                    categoria: tipoHabitacion,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget checkBoxWithDescription(BuildContext context,
      {required String title,
      required String description,
      required bool value,
      required void Function(bool?) onChanged,
      Color? activeColor}) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 35,
              width: 30,
              child: Checkbox(
                value: value,
                onChanged: (value) => onChanged.call(value),
                activeColor: activeColor ?? Colors.amber,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextStyles.standardText(
                text: title,
                color: Theme.of(context).primaryColor,
                size: 12,
                overClip: true,
              ),
            )
          ],
        ),
        TextStyles.standardText(
            text: description,
            color: Theme.of(context).primaryColor,
            size: 10,
            overClip: true,
            aling: TextAlign.justify),
        const SizedBox(height: 30),
      ],
    );
  }

  static Widget titleFormPage({
    required void Function()? onPressedBack,
    required BuildContext context,
    required String title,
    void Function()? onPressedSaveButton,
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
    Color? collapsedBackgroundColor,
    bool overClipText = false,
    Color? colorText,
    double padding = 4,
    bool showTrailing = true,
    bool withTopBorder = false,
  }) {
    return ExpansionTile(
      tilePadding: EdgeInsets.all(padding),
      shape: collapsedBackgroundColor != null
          ? OutlineInputBorder(
              borderSide: BorderSide(
                color: collapsedBackgroundColor,
                width: 1.8,
              ),
            )
          : Border(
              top: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.3,
              ),
            ),
      collapsedShape: withTopBorder
          ? Border(
              top: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.3,
              ),
            )
          : const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
      initiallyExpanded: showList,
      onExpansionChanged: onExpansionChanged,
      collapsedBackgroundColor: collapsedBackgroundColor,
      title: Row(
        children: [
          Expanded(
            child: TextStyles.standardText(
              text: title,
              color: colorText ?? Theme.of(context).primaryColor,
              size: 13,
              overClip: overClipText,
            ),
          ),
          if (showTrailing)
            Icon(
              showList
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: colorText ?? Theme.of(context).primaryColor,
            ),
        ],
      ),
      trailing: !showTrailing
          ? null
          : TextStyles.standardText(
              text: Utility.formatterNumber(total),
              color: colorText ?? Theme.of(context).primaryColor,
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
    void Function()? onChanged,
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
            if (onChanged != null)
              IconButton(
                tooltip: "Cambiar de hab.",
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.sync,
                  color: Colors.green[400],
                ),
                onPressed: () {
                  onChanged.call();
                },
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

  static Widget compactOptions(
    BuildContext context, {
    void Function()? onPreseedEdit,
    void Function()? onPreseedDelete,
    void Function()? onPressedDuplicate,
    Color? colorIcon,
  }) {
    return PopupMenuButton<ListTileTitleAlignment>(
      iconColor: colorIcon,
      tooltip: "Opciones",
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<ListTileTitleAlignment>>[
        if (onPreseedEdit != null)
          PopupMenuItem<ListTileTitleAlignment>(
            value: ListTileTitleAlignment.threeLine,
            onTap: onPreseedEdit,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Iconsax.edit_outline, color: DesktopColors.turqueza),
                TextStyles.standardText(
                  text: "Editar",
                  color: Theme.of(context).primaryColor,
                  size: 12,
                )
              ],
            ),
          ),
        if (onPressedDuplicate != null)
          PopupMenuItem<ListTileTitleAlignment>(
            value: ListTileTitleAlignment.titleHeight,
            onTap: onPressedDuplicate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Iconsax.copy_outline,
                    color: DesktopColors.cerulean, size: 21),
                TextStyles.standardText(
                  text: "Duplicar",
                  color: Theme.of(context).primaryColor,
                  size: 12,
                )
              ],
            ),
          ),
        if (onPreseedDelete != null)
          PopupMenuItem<ListTileTitleAlignment>(
            value: ListTileTitleAlignment.titleHeight,
            onTap: onPreseedDelete,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(CupertinoIcons.delete, color: Colors.red[800]),
                TextStyles.standardText(
                  text: "Eliminar",
                  color: Theme.of(context).primaryColor,
                  size: 12,
                )
              ],
            ),
          ),
      ],
    );
  }

  static Widget itemColorIndicator(
    BuildContext context, {
    required double screenWidth,
    required String nameItem,
    required Color? colorItem,
  }) {
    return Tooltip(
      message: screenWidth > 1000 ? '' : nameItem,
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: colorItem,
            size: 26,
          ),
          if (screenWidth > 1000)
            Container(
              width: screenWidth * 0.07,
              child: TextStyles.standardText(
                text: "  $nameItem",
                color: Theme.of(context).primaryColor,
              ),
            )
        ],
      ),
    );
  }

  static Widget roleMedal(String rol, Brightness brightness) {
    return Container(
      decoration: BoxDecoration(
        color: Utility.getColorTypeUser(rol, alpha: 100),
        border: Border.all(
          color: Utility.getColorTypeUser(rol)!,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextStyles.standardText(
          text: rol,
          aling: TextAlign.center,
          color: Utility.darken(
            Utility.getColorTypeUser(rol)!,
            brightness == Brightness.light ? 0.1 : -0.1,
          ),
          overClip: true,
          isBold: true,
        ),
      ),
    ).animate(
      onPlay: (controller) => controller.repeat(),
      effects: [
        if (rol == "SUPERADMIN" || rol == "ADMIN")
          ShimmerEffect(
            delay: 2.5.seconds,
            duration: 750.ms,
            color: Colors.white,
          ),
      ],
    );
  }

  static Widget buildItemGraphics({
    required IconData icon,
    required Color color,
    required String label,
    required double fontSize,
    required double iconSize,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: iconSize, // Tamaño del ícono escalable
              ),
              const SizedBox(width: 8), // Espaciado fijo entre ícono y texto
              TextStyles.standardText(
                text: label,
                color: color,
                size: fontSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
