import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/text_styles.dart';

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
  }) {
    List<String> items = elements.toList();

    if (removeItem.isNotEmpty) {
      items.removeWhere((element) => element == removeItem);
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownMenu<String>(
          menuHeight: 200,
          width:
              screenWidth == null ? null : calculateWidth ? Utility.getWidthDynamic(screenWidth) :screenWidth,
          requestFocusOnTap: false,
          initialSelection: initialSelection,
          onSelected: onSelected,
          label: Text(label),
          textStyle:
              TextStyle(fontFamily: "poppins_regular", fontSize: fontSize),
          dropdownMenuEntries: items.map<DropdownMenuEntry<String>>(
            (String value) {
              return DropdownMenuEntry<String>(
                value: value,
                label: value,
                enabled: (excepcionItem.isNotEmpty && value == excepcionItem)
                    ? true
                    : (notElements != null)
                        ? notElements.any((element) => element == value)
                        : true,
                style: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(
                        fontFamily: "poppins_regular", fontSize: fontSize),
                  ),
                ),
              );
            },
          ).toList(),
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
