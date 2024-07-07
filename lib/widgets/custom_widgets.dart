import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/utils/helpers/utility.dart';

class CustomWidgets {
  static Widget dropdownMenuCustom(
      {required String initialSelection,
      required void Function(String?)? onSelected,
      required List<String> elements,
      double fontSize = 13,
      double? screenWidth}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownMenu<String>(
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
}
