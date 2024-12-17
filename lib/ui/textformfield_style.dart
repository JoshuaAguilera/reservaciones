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
        fontSize: 10,
      ),
    );
  }

  static InputDecoration decorationFieldSearch(
      {required String label, required void Function() function, required TextEditingController controller}) {
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
        fontSize: 10,
      ),
      suffixIcon: GestureDetector(
        onTap: function,
        child: Icon(
        controller.text.isEmpty ?  CupertinoIcons.search : CupertinoIcons.multiply_circle,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
