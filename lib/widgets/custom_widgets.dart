import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWidgets {
  static Widget dropdownMenuCustom(
      {required String initialSelection,
      required String changeValue,
      required List<String> elements}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownMenu<String>(
          initialSelection: initialSelection,
          onSelected: (String? value) {
            setState(() {
              changeValue = value!;
            });
          },
          textStyle: GoogleFonts.poppins(fontSize: 13),
          dropdownMenuEntries:
              elements.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value,
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(
                  GoogleFonts.poppins(fontSize: 13),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
