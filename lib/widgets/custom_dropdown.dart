import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/utility.dart';
import 'package:generador_formato/widgets/text_styles.dart';

import '../models/prefijo_telefonico_model.dart';

class CustomDropdown {
  static Widget dropdownMenuCustom(
      {required String initialSelection,
      required void Function(String?)? onSelected,
      required List<String> elements,
      double fontSize = 13,
      double? screenWidth}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownMenu<String>(
          menuHeight: 200,
          width:
              screenWidth == null ? null : Utility.getWidthDynamic(screenWidth),
          requestFocusOnTap: false,
          initialSelection: initialSelection,
          onSelected: onSelected,
          textStyle:
              TextStyle(fontFamily: "poppins_regular", fontSize: fontSize),
          dropdownMenuEntries:
              elements.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value,
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(
                  TextStyle(fontFamily: "poppins_regular", fontSize: fontSize),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  static Widget dropdownPrefijoNumerico(
      {required PrefijoTelefonico initialSelection,
      required void Function(PrefijoTelefonico?)? onSelected,
      required List<PrefijoTelefonico> elements,
      double fontSize = 13,
      double? screenWidth}) {
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
              TextStyles.standardText(text: initialSelection.prefijo),
            ],
          ),
          textStyle:
              TextStyle(fontFamily: "poppins_regular", fontSize: fontSize),
          dropdownMenuEntries: elements
              .map<DropdownMenuEntry<PrefijoTelefonico>>(
                  (PrefijoTelefonico value) {
            return DropdownMenuEntry<PrefijoTelefonico>(
              value: value,
              label: "",
              labelWidget: Tooltip(
                decoration: BoxDecoration(color: Colors.grey[100]),
                richMessage: WidgetSpan(
                    child: TextStyles.standardText(text: value.nombre)),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(value.banderaAssets),
                      width: 20,
                    ),
                    const SizedBox(width: 10),
                    TextStyles.standardText(text: value.prefijo),
                  ],
                ),
              ),
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(
                  TextStyle(fontFamily: "poppins_regular", fontSize: fontSize),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
