import 'package:flutter/material.dart';
import 'package:generador_formato/constants/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static Text standardText(
      {String text = "", TextAlign aling = TextAlign.left}) {
    return Text(
      text,
      textAlign: aling,
      style: GoogleFonts.poppins(color: WebColors.prussianBlue, fontSize: 13),
    );
  }

  static Text buttonText({String text = "", TextAlign aling = TextAlign.left}) {
    return Text(
      text,
      textAlign: aling,
      style: GoogleFonts.poppins(
          color: WebColors.turqueza, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  static Text titleText({String text = "", Color? color}) {
    return Text(text,
        textAlign: TextAlign.start,
        style: GoogleFonts.poppins(
          color: color ?? WebColors.cerulean,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ));
  }
}
