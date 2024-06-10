import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generador_formato/components/utility.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWidgets {
  static Widget dropdownMenuCustom(
      {required String initialSelection,
      required void Function(String?)? onSelected,
      required List<String> elements, required double screenWidth}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownMenu<String>(
          width: Utility.getWidthDynamic(screenWidth),
          requestFocusOnTap: false,
          initialSelection: initialSelection,
          onSelected: onSelected,
          textStyle: GoogleFonts.poppins(
              fontSize: 13,
              textStyle: const TextStyle(overflow: TextOverflow.ellipsis)),
          dropdownMenuEntries:
              elements.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value,
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(
                  GoogleFonts.poppins(
                      fontSize: 13,
                      textStyle:
                          const TextStyle(overflow: TextOverflow.ellipsis)),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
