import 'package:flutter/cupertino.dart';
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

  static InputDecoration decorationFieldSearch(String label) {
    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10))),
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
      suffixIcon: Icon(
        CupertinoIcons.search,
        color: Colors.grey[600],
      ),
    );
  }
}
