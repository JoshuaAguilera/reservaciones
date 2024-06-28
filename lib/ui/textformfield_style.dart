import 'package:flutter/material.dart';

class TextFormFieldStyle {
  static InputDecoration decorationFieldStandar(String label) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      labelStyle: const TextStyle(
        fontSize: 13,
        fontFamily: "poppins_regular",
      ),
      labelText: label,
      errorStyle: TextStyle(
        fontFamily: "poppins_regular",
        color: Colors.red[800],
        fontSize: 13,
      ),
    );
  }
}
