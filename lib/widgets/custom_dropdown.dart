import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/utils/helpers/desktop_colors.dart';
import 'package:generador_formato/widgets/text_styles.dart';
import 'package:icons_plus/icons_plus.dart';

import '../models/prefijo_telefonico_model.dart';

class CustomDropdown {
  static Widget dropdownMenuCustom({
    required String initialSelection,
    required void Function(String?)? onSelected,
    required List<String> elements,
    List<String>? notElements,
    double fontSize = 13,
    double? screenWidth,
    String removeItem = '',
    String label = '',
    String excepcionItem = '',
    bool calculateWidth = true,
    bool compact = false,
    double compactWidth = 120,
    bool withPermisse = true,
  }) {
    List<String> items = elements.toList();

    if (removeItem.isNotEmpty) {
      items.removeWhere((element) => element == removeItem);
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: compact ? 30 : null,
          width: compact ? compactWidth : null,
          child: Tooltip(
            message: withPermisse ? "" : "No autorizado",
            child: IgnorePointer(
              ignoring: !withPermisse,
              child: ExcludeFocus(
                excluding: !withPermisse,
                child: Focus(
                  skipTraversal: !withPermisse,
                  canRequestFocus: withPermisse,
                  child: DropdownMenu<String>(
                    menuHeight: 220,
                    width: screenWidth == null
                        ? null
                        : calculateWidth
                            ? Utility.getWidthDynamic(screenWidth)
                            : screenWidth,
                    requestFocusOnTap: false,
                    initialSelection: initialSelection,
                    onSelected: onSelected,
                    label: Text(label),
                    expandedInsets: !compact ? null : const EdgeInsets.all(1),
                    trailingIcon: !withPermisse
                        ? const Icon(HeroIcons.hand_raised)
                        : !compact
                            ? null
                            : Transform.translate(
                                offset: const Offset(0, -8),
                                child: const Icon(Icons.arrow_drop_down),
                              ),
                    inputDecorationTheme: !compact
                        ? null
                        : const InputDecorationTheme(
                            contentPadding: EdgeInsets.only(top: -5, left: 15),
                            border: OutlineInputBorder(),
                          ),
                    textStyle: TextStyle(
                        fontFamily: "poppins_regular", fontSize: fontSize),
                    dropdownMenuEntries: items.map<DropdownMenuEntry<String>>(
                      (String value) {
                        bool enable = (excepcionItem.isNotEmpty &&
                                value == excepcionItem)
                            ? true
                            : (notElements != null)
                                ? notElements.any((element) => element == value)
                                : true;

                        return DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                          enabled: enable,
                          style: ButtonStyle(
                            textStyle: WidgetStatePropertyAll(
                              TextStyle(
                                fontFamily: "poppins_regular",
                                fontSize: fontSize,
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget dropdownPrefijoNumerico({
    required PrefijoTelefonico initialSelection,
    required void Function(PrefijoTelefonico?)? onSelected,
    required List<PrefijoTelefonico> elements,
    double fontSize = 13,
    double? screenWidth,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownMenu<PrefijoTelefonico>(
          width: 140,
          requestFocusOnTap: false,
          initialSelection: initialSelection,
          onSelected: onSelected,
          menuHeight: 150,
          label: Row(
            children: [
              Image(
                image: AssetImage(initialSelection.banderaAssets),
                width: 20,
              ),
              const SizedBox(width: 10),
              TextStyles.standardText(
                text: initialSelection.prefijo,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          textStyle: TextStyle(
              fontFamily: "poppins_regular",
              fontSize: fontSize,
              color: Theme.of(context).primaryColor),
          dropdownMenuEntries: elements
              .map<DropdownMenuEntry<PrefijoTelefonico>>(
                  (PrefijoTelefonico value) {
            return DropdownMenuEntry<PrefijoTelefonico>(
              value: value,
              label: "",
              labelWidget: Tooltip(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColorDark),
                richMessage: WidgetSpan(
                    child: TextStyles.standardText(
                  text: value.nombre,
                  color: Theme.of(context).primaryColor,
                )),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(value.banderaAssets),
                      width: 20,
                    ),
                    const SizedBox(width: 10),
                    TextStyles.standardText(
                      text: value.prefijo,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(
                  TextStyle(
                      fontFamily: "poppins_regular",
                      fontSize: fontSize,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
