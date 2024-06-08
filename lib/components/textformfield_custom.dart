import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/web_colors.dart';

class TextFormFieldCustom {
  static Widget textFormFieldwithBorder(
      {required String name,
      required String msgError,
      bool isPassword = false,
      bool passwordVisible = false}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2),
          ),
          constraints: const BoxConstraints(
            minWidth: 270,
            minHeight: 25.0,
            maxHeight: 100.0,
          ),
          child: TextFormField(
            obscureText: passwordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return msgError;
              }
              return null;
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelStyle: GoogleFonts.poppins(fontSize: 13),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: WebColors.azulCielo,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      )
                    : null,
                labelText: name),
          ),
        );
      },
    );
  }

  static Widget textFormFieldwithBorderCalendar(
      {required String name, required String msgError}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2),
          ),
          constraints: const BoxConstraints(
            minWidth: 270,
            minHeight: 25.0,
            maxHeight: 100.0,
          ),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return msgError;
              }
              return null;
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelStyle: GoogleFonts.poppins(fontSize: 13),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.calendar_month,
                    color: WebColors.azulCielo,
                  ),
                  onPressed: () {
                    setState(() {});
                  },
                ),
                labelText: name),
          ),
        );
      },
    );
  }
}
