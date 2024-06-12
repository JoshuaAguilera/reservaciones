import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generador_formato/helpers/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TextStyles {
  static Text standardText(
      {String text = "",
      TextAlign aling = TextAlign.left,
      bool overClip = false,
      bool isBold = false}) {
    return Text(
      text,
      textAlign: aling,
      style: GoogleFonts.poppins(
          color: WebColors.prussianBlue,
          fontSize: 13,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          textStyle: TextStyle(
              overflow: overClip ? TextOverflow.clip : TextOverflow.ellipsis)),
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

  static Text titleText({String text = "", Color? color, double size = 18}) {
    return Text(text,
        textAlign: TextAlign.start,
        style: GoogleFonts.poppins(
          color: color ?? WebColors.cerulean,
          fontWeight: FontWeight.bold,
          fontSize: size,
        ));
  }

  static Column dateTextSpecial({required int day}) {
    NumberFormat formatter = NumberFormat('00');
    String numeroFormateado = formatter.format(day);

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      titleText(text: numeroFormateado, size: 22),
      standardText(text: "Día"),
    ]);
  }

  static Text titlePagText({required String text}) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.poppins(
          color: WebColors.prussianBlue,
          fontWeight: FontWeight.bold,
          fontSize: 22),
    );
  }
}
